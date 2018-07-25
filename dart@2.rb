class DartAT2 < Formula
  desc "The Dart 2 SDK"
  homepage "https://www.dartlang.org/"
  version "2.0.0-dev.69.3"

  keg_only :versioned_formula

  if MacOS.prefer_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.69.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "d4c7ece05ba4a97a722ae21318cce15c434e34682a1e99f23cef1ec2787dd842"
  else
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.69.3/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "78d662c8c5ae7867e8987f44e63a3ebcc0b7ce5cf505d3459ad8dc14c76ef221"
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
