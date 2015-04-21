require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.9.3'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45104/dartium/dartium-macos-ia32-release.zip'
  sha256 '4bce9e23b218a97cd6385643352dc774b9a547389b23e17e12f341b448067122'

  devel do
    version '1.10.0-dev.1.9'
    url 'https://storage.googleapis.com/dart-archive/channels/dev/release/45311/dartium/dartium-macos-ia32-release.zip'
    sha256 '830b8e491914f9172db739c2c96e7c805dec94037eaeeb819957bc35a7cda976'

    resource 'content_shell' do
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/45311/dartium/content_shell-macos-ia32-release.zip'
      version '1.10.0-dev.1.9'
      sha256 '4cb3de34067ce1df1a501d3e7c0a96ef562e9cac06f8c892a268c93fa87fda8b'
    end
  end

  resource 'content_shell' do
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45104/dartium/content_shell-macos-ia32-release.zip'
    version '1.9.3'
    sha256 'c37839a82496f93739eceadd8002b2adc4b10567fece9fc6d8c93a549945dd34'
  end

  def shim_script target
    <<-EOS.undent
      #!/bin/bash
      "#{prefix}/#{target}" "$@"
    EOS
  end

  def install
    dartium_binary = 'Chromium.app/Contents/MacOS/Chromium'
    prefix.install Dir['*']
    (bin+"dartium").write shim_script dartium_binary

    content_shell_binary = 'Content Shell.app/Contents/MacOS/Content Shell'
    prefix.install resource('content_shell')
    (bin+"content_shell").write shim_script content_shell_binary
  end

  def caveats; <<-EOS.undent
     To use with IntelliJ, set the Dartium execute home to:
        #{prefix}/Chromium.app
    EOS
  end

  test do
    system "#{bin}/dartium"
  end
end
