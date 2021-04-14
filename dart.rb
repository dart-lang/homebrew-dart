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
    version "2.14.0-3.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-3.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "34785c6b109ec5be5e2b0013d3b5f44ca171095bfc70cbfc1d17b1b7c77eafcc"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-3.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "50b8a70798398f46aff90cdb0bb7b35520f7f2c248a0a2cc7bd748daf7da1c19"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-3.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a5fd484ef182a298c93cca0581e7e193d84743307798bb41ea3f8038eb42cc15"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-3.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "785c151bb4494464ebb9fb810dd63360625dcb0aaaabdeadfd467a152ddaebcc"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-3.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "2d52e95da6314f1f68a3c4672ad95592664ee14c6a8541b4914ca0b09786b875"
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
