require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.8.5'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/42828/dartium/dartium-macos-ia32-release.zip'
  sha256 '24527244a9a35bb74030762e415acd387c1c3aad50ca259d1f55accff0a397b4'

  devel do
    version '1.9.0-dev.9.1'
    dev_base_url = "https://storage.googleapis.com/dart-archive/channels/dev/release/44018"
    if MacOS.prefer_64_bit?
      url "#{dev_base_url}/sdk/dartsdk-macos-x64-release.zip"
      sha256 '8b2c6a25452072d182f8bca00f38ece83952ae0678fc2082c24d0c8378ac0e94'
    else
      url "#{dev_base_url}/sdk/dartsdk-macos-ia32-release.zip"
      sha256 '8de1e7f7fcb80afa22fd1922cd640641a4b0083d2c824cc1e01222afecb25836'
    end

    resource 'content_shell' do
      url "#{dev_base_url}/dartium/content_shell-macos-ia32-release.zip"
      version '1.9.0-dev.9.1'
      sha256 'd7c1518aa0aae73e960d319be5b281f4b7ca0a4174611cd3b77534544a427681'
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
