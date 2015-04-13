require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.9.1'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/44672/dartium/dartium-macos-ia32-release.zip'
  sha256 '071f65eb0167ff64f5deefae3bc9cf94b8264aa68395cb37ed0097bb3f8a82c4'

  devel do
    version '1.10.0-dev.1.1'
    url 'https://storage.googleapis.com/dart-archive/channels/dev/release/45089/dartium/dartium-macos-ia32-release.zip'
    sha256 '0f2e26f09b72c8bdc6251c4ee8c3726cc7f4439ab48796183253ef5d73b77963'

    resource 'content_shell' do
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/45089/dartium/content_shell-macos-ia32-release.zip'
      version '1.10.0-dev.1.1'
      sha256 'ffe7108c439ea3fdc871b826b5be4e2bccc0c95eb807a70d974bee03b22297d3'
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
