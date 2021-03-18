class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.12.2"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "cdc34e811188000090d4ac411d5ae014352b57f76e14f0e01604313781bfd540"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "5ffcdedd1f5c4d0f44bc9df7244a638111d6ecb43f8599e81a2e7ae21e08e2bd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "96cfef9bc10ac231fb1a6095da0f011adb9c2ac0c81ebf137e40c870d4eacff2"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "4b88fec15e98ffd6cfb8361deaf02dafd852655573808549996f9657e8af1a67"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "87f86519d30bc2bc7219c72c5787f55745eeb338fae5a351311b9efd24c9a038"
    end
  end

  head do
    version "2.13.0-144.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-144.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "721d91d369f037f91cca2c6a5549030d9f758acafbffff7cca2a2a9716dfef4d"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-144.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "634b08a1f5cb073b6c645c53b02cde025fcb4c8b8650cc5b60b13fab9e5c003f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-144.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "0d1d6c2aebf698f325372b202e5abeab3d3ce7c60437eb31ed6de15272ba80eb"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-144.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "687afa9bda4b2f1652f74c81375f3a3add66d8ad75f2e416da7be9fdb83d47d7"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-144.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "372e2d5fbc222a801fbaa69c401e14562cae4deb8454b74edfa7e8484c58b81e"
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
