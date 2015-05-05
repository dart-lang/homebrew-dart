require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.10.0'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45396/dartium/dartium-macos-ia32-release.zip'
  sha256 '371420feeb4105af9f1b19dd876e8c1680a1443212653a50f8ec482ab6a3821b'

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
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45396/dartium/content_shell-macos-ia32-release.zip'
    version '1.10.0'
    sha256 '78e3b2f80de0f238938c12a272ec892c0e457f395254efdd5e8696d163d569b4'
  end

  def shim_script target
    <<-EOS.undent
      #!/bin/bash
      exec "#{prefix}/#{target}" "$@"
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
