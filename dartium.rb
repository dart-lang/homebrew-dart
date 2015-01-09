require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.8.3'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/42039/dartium/dartium-macos-ia32-release.zip'
  sha256 'e939b30b11ceba061e864405477fe06e8159a6f625ca02023eceb32839d1edb4'

  devel do
    version '1.9.0-dev.3.0'
    url 'https://storage.googleapis.com/dart-archive/channels/dev/release/42684/dartium/dartium-macos-ia32-release.zip'
    sha256 '09cd09bbdb5e7390229833daac49caedf9cc65b0c5ed19bc7a9048aed58e8751'

    resource 'content_shell' do
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/42684/dartium/content_shell-macos-ia32-release.zip'
      version '1.9.0-dev.3.0'
      sha256 'bbc6580128e99cba92919c049193a925cba54578ddb8216fcf4001ec0bade45c'
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
