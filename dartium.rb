require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.6.0'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/39553/dartium/dartium-macos-ia32-release.zip'
  sha256 '1dfe8fefde53620d4917e82cf32a585e3f2faa663f70ba3f9c84fce9da925834'

  devel do
    version '1.7.0-dev.4.5'
    url 'https://storage.googleapis.com/dart-archive/channels/dev/release/41004/dartium/dartium-macos-ia32-release.zip'
    sha256 '36966b107355d6c01bd1117866ae79084c401d995077ea1bbd762872200a66b7'
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
