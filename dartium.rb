require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.8.0'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/42013/dartium/dartium-macos-ia32-release.zip'
  sha256 '5678d7f49e0f1282aaa8d10afc3f87e4ebf4684277d66c2b44cc71f20f05142e'

  devel do
    version '1.8.0-dev.4.6'
    url 'https://storage.googleapis.com/dart-archive/channels/dev/release/41978/dartium/dartium-macos-ia32-release.zip'
    sha256 '29675a3c52f71dec605b155b5524e628ec216c65c810abfb8b0930f63ecfc08c'
  end

  def shim_script target
    <<-EOS.undent
      #!/bin/bash
      open "#{prefix}/#{target}" "$@"
    EOS
  end

  def install
    prefix.install Dir['*']
    (bin+"dartium").write shim_script "Chromium.app"
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
