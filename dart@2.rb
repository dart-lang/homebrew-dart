class DartAT2 < Formula
  desc "The Dart 2 SDK"
  homepage "https://www.dartlang.org/"
  version "2.0.0-dev.69.4"

  keg_only :versioned_formula

  if MacOS.prefer_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.69.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "65d7bd604e1b3cdb30a8b8c89286fe12224d440be213b5d3f4bb9fdfb27d997e"
  else
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.69.4/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "efb40de7c5c194bf9968093fab70f0a9525bed6165f2668ad8ccca0207671d37"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]
  end

  def shim_script(target)
    <<~EOS
      #!/usr/bin/env bash
      exec "#{prefix}/#{target}" "$@"
    EOS
  end

  def caveats; <<~EOS
    Note that this is a prerelease version of Dart.

    Please note the path to the Dart SDK:
      #{opt_libexec}
    EOS
  end

  test do
    (testpath/"sample.dart").write <<~EOS
      void main() {
        print(r"test message");
      }
    EOS

    assert_equal "test message
", shell_output("#{bin}/dart sample.dart")
  end
end
