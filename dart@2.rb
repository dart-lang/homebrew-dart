class DartAT2 < Formula
  desc "The Dart 2 SDK"
  homepage "https://www.dartlang.org/"
  version "2.0.0-dev.69.1"

  keg_only :versioned_formula

  if MacOS.prefer_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.69.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b93e584f89f3fb5de94ae819f1b63c8ae9a64a707a1ee318a217eaa7f6c480fe"
  else
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.69.1/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "4c884a29da63b2396e927421dd57c8559dde332165f7b3dd2b0840e7d5675753"
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
