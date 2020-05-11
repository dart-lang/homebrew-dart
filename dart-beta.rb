class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.9.0-8.1.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-8.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "cb21babad47ad0ae4cbca986852f6364fdebe3e61d4a342f8a7d5e90bf9c12ca"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-8.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "7c749bd4617a2dfff4863685d3b3ace110319ad816f295b5c1d399914e018b51"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-8.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "8e79a5946dc0ffd085471e4bb69368ca8be8d3912c65535fc1e2af5b4da8ce59"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-8.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "41220ff37d497df47c2ae6254033c858d2d1e3a65530fd6f9e0d42d046570c84"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-8.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "4f4299ff8a73c9d6d145cd2176c9e08ca1a22a25e71c47e64888de326f735412"
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
