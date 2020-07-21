class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.9.0-21.10.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-21.10.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "decd0bcf35fa768510948c7c6f3484a995684dd0c836936a1835de7d53b7bcb9"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-21.10.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "86a10995ee34652dac7b356347b8efa1d6452a5854e2d1f3784a89d0b92f8b3f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-21.10.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "1f9d90fe26f4ee86a36116ccc028d6c78075fb4ba2b72a4ae94870e63e3b00aa"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-21.10.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "106ce12561110f310eed0bc880e0b6c11d781a50a7bb8d0f12d00dbef9bb53af"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-21.10.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "a548b7464f9ab4ff5265e73992055c48311ed6d3938af1e4c5f3bccaa21cc303"
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
