class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.12.4"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "21df868f61389e9410c6893d4afffd6ad3dedb84a4770c206ebc6ee8d302c544"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "479fd97114f8dc2e01a29bcf2c9fb46ff2c137390f6fe9f998a8d979604d33fd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "c12ef383c50262a3891e6731068b7b982540e6c874dbc31be0fd4c3e0517bd41"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e31b619e4de778ed95b00f5af92b02c9aadc5db34245823b6faedf10ac014121"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "c2e5a0d360766cbea648e63f49a8a4edb5bb64e736edb4274530ed76110caf68"
    end
  end

  head do
    version "2.14.0-85.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-85.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "0faa03973e5c3a3dc0af4c3fc81de974e7395aeb5b84857669bcb17dc2efb3f5"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-85.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "612937a30be36f716ba24b0ea19e23a44408a2cac8ff4c14856251ca4da42edc"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-85.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "7856394508b16383e3d4b04d96cf9cbec3753ea1804599fe24a1642b35cabe98"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-85.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "ce3bc6b8086ae36727fa36f57bfd5dccd440364469ac025800760613a46b6750"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-85.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "35ae3504e718dd06851c76a149d96b79f279d33816df804766aafd95573c79e0"
      end
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
