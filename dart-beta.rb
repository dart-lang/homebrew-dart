class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.12.0-133.6.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-133.6.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "bc352342c3269de4eb2677535f4032f1f45cf1cd0819d3062b6b899a0bc62916"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-133.6.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "2ee3375fe1534572f7da159a3f0cd1450ff07217f4aafc2264bf042c515c2a4d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-133.6.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "7b0cd8940a9d39ea862d6f6d2484e30fe92cd904080c020d6f71b0c703486048"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-133.6.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "887923ea35755409428042a400d245553c3837654b5d7403232847aa86d3440e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-133.6.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "3c5b14941c6a920341cd5bcd6c75210a1480f98578cb9f4a95aa8c10dbae77c6"
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
