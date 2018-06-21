class DartAT2 < Formula
  desc "The Dart 2 SDK"
  homepage "https://www.dartlang.org/"
  version "2.0.0-dev.64.1"

  keg_only :versioned_formula

  if MacOS.prefer_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.64.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "634e5b6dfc73d262e20a8f377a3663f41d0b9ec5a2d3b78ad05ea4f8e7b4f698"
  else
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.64.1/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "36d0be8b901b56716cabbcd1c8dab921f91418ce10c836e7e675e62d642337c1"
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
