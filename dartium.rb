require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.9.1'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/44672/dartium/dartium-macos-ia32-release.zip'
  sha256 '071f65eb0167ff64f5deefae3bc9cf94b8264aa68395cb37ed0097bb3f8a82c4'

  devel do
    version '1.10.0-dev.0.1'
    url 'https://storage.googleapis.com/dart-archive/channels/dev/release/44728/dartium/dartium-macos-ia32-release.zip'
    sha256 '950c17be0cd53555c72e26743d1f55e8117493dfc6364092bb2fed3504f1a8eb'

    resource 'content_shell' do
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/44728/dartium/content_shell-macos-ia32-release.zip'
      version '1.10.0-dev.0.1'
      sha256 '678170a20cd77d71223f32f282fc5de66dea9f72eb50d09aca0221dba372f083'
    end
  end

  resource 'content_shell' do
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/44672/dartium/content_shell-macos-ia32-release.zip'
    version '1.9.1'
    sha256 'aaecaf36c15763306fc352920f580ebbf68bb82cd9bac4e3b21647fde660305c'
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
