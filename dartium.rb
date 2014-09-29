require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  require_relative 'dev_info'
  require_relative 'stable_info'

  version DartStable::VERSION
  url "https://storage.googleapis.com/dart-archive/#{DartStable::DARTIUM_FILE}"
  sha256 DartStable::DARTIUM_HASH

  devel do
    version DartDev::VERSION
    url "https://storage.googleapis.com/dart-archive/#{DartDev::DARTIUM_FILE}"
    sha256 DartDev::DARTIUM_HASH
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
