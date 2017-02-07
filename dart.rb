require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.21.1'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.21.1/sdk/dartsdk-macos-x64-release.zip'
    sha256 'bf5d710d7ca1751b7c7e5312a616aa2b58ccbda80c64864f2aba007cfaacee75'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.21.1/sdk/dartsdk-macos-ia32-release.zip'
    sha256 'a237fb6681ead44b4f2df04d590be510c7b11dab0ca0ceacec05eb911d2e730a'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.22.0-dev.10.5'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.22.0-dev.10.5/sdk/dartsdk-macos-x64-release.zip'
      sha256 '7ee317cc4a9d5986cec412f9e4528e34a9669eee2d2e46879f8c4bf545715925'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.22.0-dev.10.5/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '294d15998466f58b2d2a19418e35b5c9bc339c631b2d90c6f5358dab6eb13332'
    end

    resource 'content_shell' do
      version '1.22.0-dev.10.5'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.22.0-dev.10.5/dartium/content_shell-macos-x64-release.zip'
      sha256 '4839cb1b399cd052ee583d69973fefb818bde4af1e2aa18af25732f276292b70'
    end

    resource 'dartium' do
      version '1.22.0-dev.10.5'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.22.0-dev.10.5/dartium/dartium-macos-x64-release.zip'
      sha256 '39f4bdba3fb4333fb0209a381d80f303c1e72d10f0d76a8b169d12208ed6257e'
    end
  end

  resource 'content_shell' do
    version '1.21.1'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.21.1/dartium/content_shell-macos-x64-release.zip'
    sha256 '83af1c46ddbf85d5ff151e5a72df9a6417dbf5eef44d1754c4c264de9e2c8c2f'
  end

  resource 'dartium' do
    version '1.21.1'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.21.1/dartium/dartium-macos-x64-release.zip'
    sha256 '8d9193496a727c1f7b5c7a63f476a4a39339c7db7ee14357b01c8d3c5a76a89f'
  end

  def install
    libexec.install Dir['*']
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]

    if build.with? 'dartium'
      dartium_binary = 'Chromium.app/Contents/MacOS/Chromium'
      prefix.install resource('dartium')
      (bin+"dartium").write shim_script dartium_binary
    end

    if build.with? 'content-shell'
      content_shell_binary = 'Content Shell.app/Contents/MacOS/Content Shell'
      prefix.install resource('content_shell')
      (bin+"content_shell").write shim_script content_shell_binary
    end
  end

  def shim_script target
    <<-EOS.undent
      #!/usr/bin/env bash
      exec "#{prefix}/#{target}" "$@"
    EOS
  end

  def caveats; <<-EOS.undent
    Please note the path to the Dart SDK:
      #{opt_libexec}

    --with-dartium:
      To use with IntelliJ, set the Dartium execute home to:
        #{opt_prefix}/Chromium.app
    EOS
  end

  test do
    (testpath/'sample.dart').write <<-EOS.undent
      void main() {
        print(r"test message");
      }
    EOS

    assert_equal "test message\n", shell_output("#{bin}/dart sample.dart")
  end
end
