class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.13.0-116.1.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-116.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "76b2beea48eeb2e0429eae3996f603d50911fa91ebfb1f940b9d995762bb6d3f"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-116.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "f9d8f6665a4bb38028c7bf44c3ddc584518b0ca465cfda1631760003420e3829"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-116.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "ae4898e05b83a86c448c56344408bde660e1ee745b314d672b97a66a3124e802"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-116.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0f9d1c0c3ac4ee47b352337e9c167f5fa1092004fa4c2059764b6d88c3be5532"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-116.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "1f405a50e6b66d0059ae2d1e80a5bf17dcbc2828a05d069fed9371d046f15c26"
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
