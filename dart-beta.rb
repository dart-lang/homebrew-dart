class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.13.0-211.13.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-211.13.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "682e515bcbee4d65ddb9f904e8026a4ee5af7310cfed4bf3256412487e9f1861"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-211.13.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "08806ecf95cc7545286a824089666612491c3151cbf58da49d03e66748a01e62"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-211.13.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "f0af6b8e84026c9264b57d079195ba08a328ccc2ac2dcc72fb95a57dd19ac431"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-211.13.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "94670efa3fbad0bbc1f027915f77daf5c3e08e8e55747dfaa4865ba198639d63"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-211.13.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "feacab22b0021699cf6d54489362d4ddc0ed5d09639c330783a0c4d7fbafb982"
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
