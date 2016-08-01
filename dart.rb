require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.18.0'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.18.0/sdk/dartsdk-macos-x64-release.zip'
    sha256 '8ca53818d7b4a15d7247623243245d8a092642d3014b1c66e34db175e9ccc0a4'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.18.0/sdk/dartsdk-macos-ia32-release.zip'
    sha256 '0db92f4465494d1e6d9b23d11bd241691bcd396ce2965a4c97490f6d5b99897d'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.19.0-dev.2.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.19.0-dev.2.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 'b2d79d4523595a45d7a6f0209c721fc6a62de795dcea0d278c645f35b30d9125'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.19.0-dev.2.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '8c921fc6707ace695ed28d4a4296ae6991ffbb01dcb7932934039a24a5cdb558'
    end

    resource 'content_shell' do
      version '1.19.0-dev.2.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.19.0-dev.2.0/dartium/content_shell-macos-ia32-release.zip'
      sha256 '05b1e421d6ba7920025d79fb72fc3e15969fa40238f3a2eb0856a6b8bcc126fa'
    end

    resource 'dartium' do
      version '1.19.0-dev.2.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.19.0-dev.2.0/dartium/dartium-macos-ia32-release.zip'
      sha256 '28fdf586357ec12b8962295cf4fb9e721ecb30d583f3798b0d97c87cf2947dc7'
    end
  end

  resource 'content_shell' do
    version '1.18.0'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.18.0/dartium/content_shell-macos-ia32-release.zip'
    sha256 '320c711e09631a75b3d5c68eb83d5abf5435ce60dc1894b805d9c6ba75e42cb3'
  end

  resource 'dartium' do
    version '1.18.0'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.18.0/dartium/dartium-macos-ia32-release.zip'
    sha256 '66d0d3e51579cd422396b1c14a4afaa9f9db0549453f482311d42c51400b9373'
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
