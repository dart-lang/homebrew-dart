require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.8.5'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/42828/dartium/dartium-macos-ia32-release.zip'
  sha256 '24527244a9a35bb74030762e415acd387c1c3aad50ca259d1f55accff0a397b4'

  devel do
    version '1.9.0-dev.10.2'
    url 'https://storage.googleapis.com/dart-archive/channels/dev/release/44260/dartium/dartium-macos-ia32-release.zip'
    sha256 '7140ac7ed56c1739fe9658571c520a9559b1352d63e7851d402720435103908b'

    resource 'content_shell' do
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/44260/dartium/content_shell-macos-ia32-release.zip'
      version '1.9.0-dev.10.2'
      sha256 '2f4f7609ba3e2f0b1fd253ca1fc7c0e0d5aa5f6130f11454d2b4e54d5867ab32'
    end
  end

  resource 'content_shell' do
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/42828/dartium/content_shell-macos-ia32-release.zip'
    version '1.8.5'
    sha256 'a74c247cff7a33470956141afc3ca66ac8f99f23087964391bfd005d73da8b53'
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
