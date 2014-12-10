require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.8.3'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/42039/dartium/dartium-macos-ia32-release.zip'
  sha256 'e939b30b11ceba061e864405477fe06e8159a6f625ca02023eceb32839d1edb4'

  devel do
    version '1.9.0-dev.0.0'
    url 'https://storage.googleapis.com/dart-archive/channels/dev/release/42033/dartium/dartium-macos-ia32-release.zip'
    sha256 '5909f9289b68b5c334a5be2cc3cd7664ab3151f26b4817fcac7d6f1601646b20'

    resource 'content_shell' do
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/42033/dartium/content_shell-macos-ia32-release.zip'
      version '1.9.0-dev.0.0'
      sha256 'b78836ca14786542898e34ad806c94852b258575a559d82ad1e84d850627c5cf'
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
