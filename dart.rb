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
    version "2.13.0-161.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-161.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "5855e74792a8669fd543dfb093ca0b429685604f2e439d61c08c5015c534f09e"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-161.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "576b265b4b5ae7ab9c7e43720a9754b95a311b9e0c464d9aaf11bbe01dc4b8a3"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-161.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "28bf16587b969fc7581bf9192ad593fb3e7d06d1cfdf989270c2b7d23a4d90bd"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-161.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "d10ef0ea99cb29ba3d2d2c6aabdc8545ac4bc832dca1696711565c04cad05c07"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-161.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "9df298a59620deafd481b9f16cdc75010b0836b1a5c95e8af9c484f9b064e362"
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
