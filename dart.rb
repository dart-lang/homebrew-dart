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
    version "2.13.0-211.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-211.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "7b13b4e05880131a6003ae9c8ee2f083bb3bd6c3e6596c670eec0aacac4d1211"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-211.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "52f9e01aee7540b0f4a9af39bb887af1eaabe738a92d99ecd2b54369edd41f13"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-211.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "ab1366040453fe22223ed202c7a90e98a221ac20aca00539600f356146e60fff"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-211.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "8c3f439641cc2f6c43ac2a48216f44c572afc538b9786bcead7172bf1d2bd6f2"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-211.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "a3293073638e06d00bf3775ac5e1e7ad9fe54ecb49c4432afba33dab321c7eed"
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
