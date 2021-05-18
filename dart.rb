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
    version "2.14.0-115.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-115.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "3e4f3c497418dde02ecfc625d39ae93fb42d46869333be6dad98ada60de665d7"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-115.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "7533296ebc05bbf131a94602251410cfe8278e11bcca96835ebdd8b4edf3aa2a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-115.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "ba9a43eb99aa22e85e5356e26b44e08cdd751f1c29965c073963d17408df2ea1"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-115.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "628bd3b9ae6ad3b01c850d23fe90e51962574f2be05e96a9c37af35d61db264e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-115.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "e77473e8a28cb4d8f653ca783819db2748ee8c0b0eb799b7bdccf5359b6c689e"
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
