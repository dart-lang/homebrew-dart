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
    version '1.22.0-dev.7.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.22.0-dev.7.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 '6179b731ae09d5647d21f110b1e413114937f6c6ba9723bf1d75b32d8136b0fe'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.22.0-dev.7.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '5549259a8b1928f2765a4972b4389b990e8a9590926b92bfa6f3e5079a318782'
    end

    resource 'content_shell' do
      version '1.22.0-dev.7.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.22.0-dev.7.0/dartium/content_shell-macos-x64-release.zip'
      sha256 'f90e4953bf4e5f7f144961a7519f9138bbce1faa5449cfca2cbda73ed44b7808'
    end

    resource 'dartium' do
      version '1.22.0-dev.7.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.22.0-dev.7.0/dartium/dartium-macos-x64-release.zip'
      sha256 'c0117428ee38bd063669399bd481e967dfbb55fa572edfd4cc7f152fbe150818'
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
