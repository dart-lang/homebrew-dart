require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.8.5'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/42828/dartium/dartium-macos-ia32-release.zip'
  sha256 '24527244a9a35bb74030762e415acd387c1c3aad50ca259d1f55accff0a397b4'

  devel do
    version '1.9.0-dev.4.0'
    url 'https://storage.googleapis.com/dart-archive/channels/dev/release/42856/dartium/dartium-macos-ia32-release.zip'
    sha256 '4f63f2353a4e56ee5b6afc475f42bb4123a757c6376fa4239c56a0cd1a453709'

    resource 'content_shell' do
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/42856/dartium/content_shell-macos-ia32-release.zip'
      version '1.9.0-dev.4.0'
      sha256 'd0a62424f2324adcd8c44794d8154ea2e092be75cd8c395c37c3bd509a2a85c1'
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
