class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.12.0-133.7.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-133.7.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "e3932ab899d6761cdacd0ed00d4e4af0022560936c2c96f1185f0165a97a8671"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-133.7.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "fe7eab91fd5c6912e5e8c4394866dcd8176f35685e80533d4b43ea947ab8e453"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-133.7.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "c734eee4d73cee0c41893c243dfbfa3c6ec3079b80c69fb4d36bb28490fe50c5"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-133.7.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "69a91bff8e93d6936a69a6fda4674672f735dae72c1c86d51c50bfdfa9e80195"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-133.7.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "67af7e023acaf5cf0fba6c75d6545eed8d8a3847dfaf05a827915fa8f8599f70"
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
