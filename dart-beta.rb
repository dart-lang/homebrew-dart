class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.9.0-21.2.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-21.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "058b2c29e91e2a4852bf0674014ea7117b5b910d3f1d41cbefbe167d750eea21"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-21.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "9f969229a1f233d06944d4a0c5bfc7edd8ee91da6b0f8d716fc2a1eb884ef8e3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-21.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "df04c56d9e830f5bd5e4e8a0cdf1e871ef8bfc61c4fb5dc2e5e101469b48e187"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-21.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "58f65abdbb266fe136d13f83ffe3c1c43613070acb83493132385b701c4e04b3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-21.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "b5f1fb6aadd9e454eb8594209fb9abbbb05b763875b1acbb2296113d85d39e02"
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
