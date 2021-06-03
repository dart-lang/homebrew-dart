# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-188.5.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "29ca01aa3791f22e18c3a650c112199dc847c6b46a4ed4acea6acc7a6b30a939"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-188.5.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "11c2e3a35e0a13de20e5d88831db69bd7d18c077b10c77cbabd61dc36e473ba7"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-188.5.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "7e6abbc0245f9873bbcb50ac54905bd7123052bee02e62913a3f7758d53749f4"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-188.5.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "3d7c0360772b663b248898819ce5bdb73487aa1c021db2fc94f501580d26b626"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-188.5.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ac3289d66378dc4cfc6bfd46bed29ad885fa077f6d08176bd62dd28d9b0a8252"
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
