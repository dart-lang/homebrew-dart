require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.10.1'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45692/dartium/dartium-macos-ia32-release.zip'
  sha256 'f981aa9074386293bcdc69b3adce8118ef7bdf801756d93eefc026f2095d4cc1'

  devel do
    version '1.11.0-dev.5.0'
    url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.11.0-dev.5.0/dartium/dartium-macos-ia32-release.zip'
    sha256 '3650402751ee3ee2aa641aa19363a7a29ae71ace13b6ce78a387927f98ce5378'

    resource 'content_shell' do
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.11.0-dev.5.0/dartium/content_shell-macos-ia32-release.zip'
      version '1.11.0-dev.5.0'
      sha256 'c82d531066cbbda3c2b44a242c2c08a4d4e7e7bba1520b295468ac7740225249'
    end
  end

  resource 'content_shell' do
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45692/dartium/content_shell-macos-ia32-release.zip'
    version '1.10.1'
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
     To use with IntelliJ, set the Dartium execute home to:
        #{prefix}/Chromium.app
    EOS
  end

  test do
    system "#{bin}/dartium"
  end
end
