require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.8.5'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/42828/dartium/dartium-macos-ia32-release.zip'
  sha256 '24527244a9a35bb74030762e415acd387c1c3aad50ca259d1f55accff0a397b4'

  devel do
    version '1.9.0-dev.8.0'
    url 'https://storage.googleapis.com/dart-archive/channels/dev/release/43715/dartium/dartium-macos-ia32-release.zip'
    sha256 'eb5816ac2ef856e786199872d7a1f4aa2e5fba5d5debc3f62edbfb4fa67468ca'

    resource 'content_shell' do
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/43715/dartium/content_shell-macos-ia32-release.zip'
      version '1.9.0-dev.8.0'
      sha256 '0bd2e2ef7225a08a302e1f233a95f63cfd546566f632608afe379a146e0cceec'
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
