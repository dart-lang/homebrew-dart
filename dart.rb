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
    version "2.14.0-18.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-18.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "8e3e14e411dbdfa5c8cdc4c24e08c40e052c80f8faa4874881d6e4ae2caec2e2"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-18.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "cc0ebf25d652e25572f1b99783724d80d0a26f81097a8972c1f07c2468d7f004"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-18.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "69451a1c5fb3e53eadcb2572aee54f64dbdd240c7df4d5ffc672c7de2c8d3a2b"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-18.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "d7d829761b1290810934b351230d3d8ac710e09d34c4cf337a2fd27fc30fcfa0"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-18.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "302338552f8f75178c55cc9a852037db92e5ebcaab908b1da768444ebd3e9f09"
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
