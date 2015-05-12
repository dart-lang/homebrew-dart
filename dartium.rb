require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.10.0'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45396/dartium/dartium-macos-ia32-release.zip'
  sha256 '371420feeb4105af9f1b19dd876e8c1680a1443212653a50f8ec482ab6a3821b'

  devel do
    version '1.11.0-dev.0.0'
    url 'https://storage.googleapis.com/dart-archive/channels/dev/release/45519/dartium/dartium-macos-ia32-release.zip'
    sha256 'a11e016297036163c44c15f562a383d91307933442aaaf79813372f574183124'

    resource 'content_shell' do
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/45519/dartium/content_shell-macos-ia32-release.zip'
      version '1.11.0-dev.0.0'
      sha256 '8abd1508fdf12e5b2070753b19600faa90a9f3363e4bc20a035880bcee5e82fc'
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
