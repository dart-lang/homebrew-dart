# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Dart Beta SDK"
  homepage "https://dart.dev"

  version "2.14.0-188.3.beta"
  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-188.3.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "10ff49c3070b37a7879731813305a1d3454ab6e8e6324f5e197272650e7e1eb4"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-188.3.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "caeb5a18e7e309096d07755d3abb8398024995e133e19cc55109679abd11376d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-188.3.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "059e92165664c11c8fcfe1904ce07541d7c2699f7bb55d09076bd8be0924bc10"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-188.3.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "a6cedfc94978cb2e1b0b9d3ae3983ebe2ecfcb1f4fc89aad74124adb81e4c9e6"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-188.3.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "dba19a332c5414561c480e4380283e3b7314525bc01b55324629e083b221782f"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]
  end

  def caveats
    <<~EOS
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

    assert_equal "test message\n", shell_output("#{bin}/dart sample.dart")
  end
end
