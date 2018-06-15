class DartAT2 < Formula
  desc "The Dart 2 SDK"
  homepage "https://www.dartlang.org/"
  version "2.0.0-dev.63.0"

  keg_only :versioned_formula

  if MacOS.prefer_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.63.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "eeb564025cc5b99d56c87df8f2b5b17c5db57adf26dc05a8f9abe2a7a6da8641"
  else
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.63.0/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "8ed3728e1c815b0e045ee785bb163fadb385f053dd773408d7a1c63e443df5a4"
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
