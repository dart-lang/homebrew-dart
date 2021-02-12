class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.12.0-259.12.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.12.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c8ee278a8a6051ac4cc6c986844c615c919fa4cb9150f93f515f2d794fa801e3"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.12.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "d9c8c9466e53450f06833f8aceff59b0cf8c78809ee0f8fd9f092a19693567e3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.12.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "9963fd571871b423801af17225f55a26cebae40bae2a1a316913ef2c8439d3ca"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.12.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b5110ffa8d178d97951a6bddcf9954136ac1d17a5fd25d5bb1a2d5165a1fec6d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.12.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ff4f8498693b22e27f09db9bd51e385af8d4d2213631e2d3055d5aafd0fb05a1"
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
