# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.0.0-218.1.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-218.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b3f6af65b86537ff23c196c11936bdf1cea1d3dba1105dfd5b7cec41bc044b45"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-218.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "8d8e7ff8d361e2b566935e9a0900890336a53c12416a9611c72d16f2e980c828"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-218.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "da65d6733d9cca10f04cf981c97f3af7835e51afda84dce73f2e6fea8848c21b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-218.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "1daef3cfb1d5ecb4399a857457b290f8260228caae0cdc3092002bd6e8a57a88"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-218.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b0cd5dacc35e56ca569125a0cdab4539580465a4c0f820311c3f7e22e6f817b4"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-218.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "0edea02e68ca5d6becbc58c1b70d378ad4b656f2832530cd57a2fb235aad5829"
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
