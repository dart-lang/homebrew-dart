require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.6.0'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/39553/dartium/dartium-macos-ia32-release.zip'
  sha256 '1dfe8fefde53620d4917e82cf32a585e3f2faa663f70ba3f9c84fce9da925834'

  devel do
    version '1.7.0-dev.1.0'
    url 'https://storage.googleapis.com/dart-archive/channels/dev/release/39799/dartium/dartium-macos-ia32-release.zip'
    sha256 '674d212c15edf0a2d33c8ab05f9bd11ae8def747c64f015752f8f3a0dd9ed5dd'
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
