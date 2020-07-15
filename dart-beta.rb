class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.9.0-21.4.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-21.4.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "6e56da254c170027819f508f1965599a78d226a7b5e9bcff1b2c5e179989afa9"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-21.4.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "016da104a880cea02eee018018bd49331ce65aac24eea80e0a8df92ddbdf4b13"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-21.4.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "fa8f457f512baa3888fe226ea9462bd43c98440320451030234c50c60515d198"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-21.4.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0f8cbef63c3777704a5d43c7957b33223aaf9c0530c15063a749a017763f78e2"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-21.4.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "52c97a0745b4365e0c7d4f9bcccc8e58abf30b64e5c30ed9adebc293d98028cc"
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
