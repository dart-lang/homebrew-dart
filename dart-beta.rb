class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.10.0-110.5.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-110.5.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "a80aed10942fda812646a8cf5bcc57ff62d55f2055994c91ade86bee905396fe"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-110.5.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "e6ab11c93f3316f5aef43f367d999d78a3b75cf5ff50b225145b091b1df976d7"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-110.5.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "3e88e9fda0565c1e116254440009054a4009f5068f3c949cd989b663261274c5"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-110.5.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "3fa1dd0924afa090dc666431fb06c624d965967bd97fea8e42c2511598225ec3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-110.5.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "69745f2caf4d5bf57a7629eddcacb7e6f2510f1fd95313ce5a3265ba8c02a514"
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
