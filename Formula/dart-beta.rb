# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.1.0"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-134.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "247c3f702c836f5ad93a5dcb80fe83e29b8151c124a434f4cd981bf35ef0ee0f"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-134.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "029806db348a31dbc13db3915ea84379d4da1724ca9ef489823554501734f4bd"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-134.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "dc85f9d7a739b4002ddeda181ce53c4e2c653c01fbd3c8096676ee99930f61f6"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-134.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "5c37bc0823a5b72d68fe6b29fb049a8972c363acd0b3eb43ac80c01a0b3b1085"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-134.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "a6166776794dd06f146877de94e09e688314a53b1c44429ed06ee03e29a6e5a8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-134.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "794ed55872afe6305c6a8231b324989ca212abd95d1e0b912d4899da9a1af308"
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
