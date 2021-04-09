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
    version "2.13.0-216.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-216.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "a7748cda3d7c177385994da6d24b6a317e2808a721dc7ac38cda0f1724eb8f0b"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-216.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "bdde62c7e3533f2cd9ea680a1c67330165dc2466101adc4bf5d242edc0164e38"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-216.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "581d4fcba19cab5f61c47e315506f04edfb65a0940deda8023342cc7ac1ceeab"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-216.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "d41332e5c48db561e1b69ef522cca6e9e1999946f2f969d54d7ac8a9d6dd26a7"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-216.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "52eb784e65f2f3f33a1c336bbaae33fbf5200e5e0b151e98257d15840d6ed8e3"
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
