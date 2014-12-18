require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.8.3'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/42039/dartium/dartium-macos-ia32-release.zip'
  sha256 'e939b30b11ceba061e864405477fe06e8159a6f625ca02023eceb32839d1edb4'

  devel do
    version '1.9.0-dev.1.0'
    url 'https://storage.googleapis.com/dart-archive/channels/dev/release/42241/dartium/dartium-macos-ia32-release.zip'
    sha256 '2538a0f78c0624fe1c964774a69a9fbf9772267b7bc11964994eae9790ccecba'

    resource 'content_shell' do
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/42241/dartium/content_shell-macos-ia32-release.zip'
      version '1.9.0-dev.1.0'
      sha256 '00d384c2e3316f1090e4969a84f8553bcdd39007e2efeb76f17fe1b4ba6dbd18'
    end
  end

  resource 'content_shell' do
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/42039/dartium/content_shell-macos-ia32-release.zip'
    version '1.8.3'
    sha256 'a5097a7e4dd9d63a29943fc805f63157f358878024bd3eeb656f73de3d122e70'
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
