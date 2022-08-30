# typed: false
# frozen_string_literal: true

class DartAT217 < Formula
  desc "Dart SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.7/sdk/dartsdk-macos-x64-release.zip"
    sha256 "ba258fff40822cb410c4f1f7916b63f0837903a6bae8f4bd83341053b10ecbe3"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.7/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "a4be379202cf731c7e33de20b4abc4ca1e2e726bc5973222b3a7ae5a0cabfce1"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.7/sdk/dartsdk-linux-x64-release.zip"
      sha256 "ba8bc85883e38709351f78c527cbf72e22cd234b3678a1ec6a2e781f7984e624"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.7/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "6a4ebb50bd2e3a687dffc88640ac8452cfc713bb84601c45869f04c5aa2dd056"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.7/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "ee0acf66e184629b69943e9f29459e586095895c6aae6677ab027d99c00934b6"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.7/sdk/dartsdk-linux-arm-release.zip"
      sha256 "701de8f09d92abadbee8773828c40f52a173fe5eae378d3bf84fd6becb9242f4"
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
