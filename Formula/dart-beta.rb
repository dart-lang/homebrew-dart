# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.0.0-290.2.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-290.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c2ba7882681e0f022a017d5d208782538569797aa7902cf6e7088b39e1710f53"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-290.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "f1a1c9e8c5774c705b23f64d2bb1e19fc59c82f97b0edf16458895f2bd9c3f20"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-290.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "f487677d3889ec5c35d08946f33065530c389e4e68da55a0560a87068ff1371b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-290.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "c21859480b6f6459497040f7f7ccb5518f269a2cb136413254dd05baf12a1c7e"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-290.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "7fbe826943919912786fd64a5e0ebf55a5bcdaf05e160719401e935d84755799"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-290.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "b10ddeac263294b2668cb2f15603667781d313cffa2c84fc76f7125164ec6a76"
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
