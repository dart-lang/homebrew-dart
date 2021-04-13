class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.13.0-211.1.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-211.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "4222b9889cbe0375dd0a94f5d8179acc3ebf5ab19465d0d8f0e2ab7405abed54"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-211.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "a814bfb5f0ac562538b13d91fa68d819cd9ec4938ec5a6fd7d73be9ea02ddfb0"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-211.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "d96a31698dd01e0b35324b0da3c839fe26db01307d9c07dd81cf83cf26fc578e"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-211.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "468e181e975b09db5057abeebc723aa3794436c0c401c5a99d4062b58932811e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-211.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "464686befb21594c9bf7af92f863e44d4d3d56683f3b2390fd7837bc631c584d"
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
