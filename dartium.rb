require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.10.0'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45396/dartium/dartium-macos-ia32-release.zip'
  sha256 '371420feeb4105af9f1b19dd876e8c1680a1443212653a50f8ec482ab6a3821b'

  devel do
    version '1.11.0-dev.3.0'
    url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.11.0-dev.3.0/dartium/dartium-macos-ia32-release.zip'
    sha256 '5e1a818ea1ee93fd1f1489403c3d30d8f5d6729f6738d3bf7e03e3780b5f79ec'

    resource 'content_shell' do
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.11.0-dev.3.0/dartium/content_shell-macos-ia32-release.zip'
      version '1.11.0-dev.3.0'
      sha256 'ab0b015fe437381c5f935b34f2071d08580abdc17a2d2965d6bfce190da79090'
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
