class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.10.5"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "31a507a0baad581704fefee2d37ad7c028970c4e56799d5a0c206dc38ba862ed"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.5/sdk/dartsdk-linux-x64-release.zip"
      sha256 "5037a2c0fd631afc1e77e8ef86fe1ab60420d810cab67ac86f4179d9f7a866d5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.5/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "c7319de95d1e9c471d8dbe80ebdabc0c437e5ec21c7814c96b79a9ba79c6e481"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c5cf15f6cd6d2ed5212a0545936d59398a8366878e90a022675c9b443c1f484b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "12db2a878a450586da9cba8f22adaec23ae2d7c8b4838a2be58687c28d5b6814"
    end
  end

  head do
    version "2.12.0-259.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-259.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "df32db9c054ab149f46c650d042a69e44fdd154b6adfdc1b583a23a880c44597"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-259.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "85ad31be61602ead90a11500c1188aee07b08ae44233972d34df8818f32966d6"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-259.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "523992788e0ea2895155309a025f8102447f37d347a351097c698d003b388c7c"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-259.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "3bc0987c78d7bdeb5317f30ad5454ee332f0409a5d63ebaf0bdc5b82b0448a81"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-259.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "2c0353a660d0d97a86b97346a6e2fda40fb336fd6766d778fad3f1bd6ab51b76"
      end
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
