require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.10.1'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45692/dartium/dartium-macos-ia32-release.zip'
  sha256 'f981aa9074386293bcdc69b3adce8118ef7bdf801756d93eefc026f2095d4cc1'

  devel do
    version '1.11.0-dev.5.2'
    url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.11.0-dev.5.2/dartium/dartium-macos-ia32-release.zip'
    sha256 'cf3d93ec92dbf954df8d022ed0e56ce4d0c64c7c28182f51b351b63eaec49703'

    resource 'content_shell' do
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.11.0-dev.5.2/dartium/content_shell-macos-ia32-release.zip'
      sha256 'd96bb179d3c32eea96f3beda1e4e880b8507395b768399efeda81917aecc697e'
    end
  end

  resource 'content_shell' do
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45692/dartium/content_shell-macos-ia32-release.zip'
    sha256 '7b50870dbe73bc7200f9d3da43c0fc7e301175cb7ac80c90e8d7ddc423f0b1b6'
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
    DEPRECATED
      In the future, use the `dart` formula using
      `--with-dartium` and/or `--with-content-shell`

    To use with IntelliJ, set the Dartium execute home to:
        #{prefix}/Chromium.app
    EOS
  end

  test do
    system "#{bin}/dartium"
  end
end
