require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.10.1'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45692/sdk/dartsdk-macos-x64-release.zip'
    sha256 '0408c62995c24422dd3c0a34fbc23d46cda2d23848135e854c4811004a21881b'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45692/sdk/dartsdk-macos-ia32-release.zip'
    sha256 '30f05f40617ff63bd9ad73abd2cb5c227f034f226438150f74ccb10f94d6c6db'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.11.0-dev.5.2'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.11.0-dev.5.2/sdk/dartsdk-macos-x64-release.zip'
      sha256 '1df07c2ca88fb5b1619b98816c7be86c8377feb07adf3c9bdcd217a3fa260f12'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.11.0-dev.5.2/sdk/dartsdk-macos-ia32-release.zip'
      sha256 'e01da05b2139b98dc00d9d396f7680f115977ce3a8a37da006e79f02d08b1234'
    end

    resource 'content_shell' do
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.11.0-dev.5.2/dartium/content_shell-macos-ia32-release.zip'
      sha256 'd96bb179d3c32eea96f3beda1e4e880b8507395b768399efeda81917aecc697e'
    end

    resource 'dartium' do
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.11.0-dev.5.2/dartium/dartium-macos-ia32-release.zip'
      sha256 'cf3d93ec92dbf954df8d022ed0e56ce4d0c64c7c28182f51b351b63eaec49703'
    end
  end

  resource 'content_shell' do
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45692/dartium/content_shell-macos-ia32-release.zip'
    sha256 '7b50870dbe73bc7200f9d3da43c0fc7e301175cb7ac80c90e8d7ddc423f0b1b6'
  end

  resource 'dartium' do
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45692/dartium/dartium-macos-ia32-release.zip'
    sha256 'f981aa9074386293bcdc69b3adce8118ef7bdf801756d93eefc026f2095d4cc1'
  end

  def install
    libexec.install Dir['*']
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,docgen,dart?*}"]

    if build.with? 'content-shell'
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
      #!/bin/bash
      exec "#{prefix}/#{target}" "$@"
    EOS
  end

  def caveats; <<-EOS.undent
    Please note the path to the Dart SDK:
      #{opt_libexec}

    --with-dartium:
      To use with IntelliJ, set the Dartium execute home to:
        #{prefix}/Chromium.app
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
