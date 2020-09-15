class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.10.0-110.1.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-110.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "de56ce313e7210de097ed8b35509c2db42390bec00f138d1950f7b9757ad6835"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-110.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "54a4c37cd0308fdcc446584866cc6c69cedccc8fae5925a177962a851ab9c4e8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-110.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "38167097df973bb5b1ae2781e4d9b45ef1b9bfbba351cbf686277171180ce5eb"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-110.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "8200bc5c2551605fff64194399ff4267ae409ace796b84c842b4486c61ddd1b0"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-110.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "daa50d3303485411d985d0c8d722df90167d70cfb28aa433078523414c66aee1"
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
