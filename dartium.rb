require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.9.3'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45104/dartium/dartium-macos-ia32-release.zip'
  sha256 '4bce9e23b218a97cd6385643352dc774b9a547389b23e17e12f341b448067122'

  devel do
    version '1.10.0-dev.1.10'
    url 'https://storage.googleapis.com/dart-archive/channels/dev/release/45369/dartium/dartium-macos-ia32-release.zip'
    sha256 '5dce3670bc450fc05efb2a8ba516a20b331a64eb2d0d0e60f96c24307d7dc1c7'

    resource 'content_shell' do
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/45369/dartium/content_shell-macos-ia32-release.zip'
      version '1.10.0-dev.1.10'
      sha256 'a1e56f8f639927ce76f0f248b1e63b4ef4466ad7d8ee88a641be94345e0703e4'
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
