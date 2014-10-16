require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.7.2'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/41096/dartium/dartium-macos-ia32-release.zip'
  sha256 'b84e28ca2024318735b3e659e515092e9b6b21ba52cf8f59e9c9807a9fc79680'

  devel do
    version '1.7.0-dev.4.6'
    url 'https://storage.googleapis.com/dart-archive/channels/dev/release/41090/dartium/dartium-macos-ia32-release.zip'
    sha256 'a4476ed9dc1f540ada173d83c3104d382094914ff431c09493077a2326406a6c'
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
