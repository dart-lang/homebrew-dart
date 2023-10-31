# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.3.0-65.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-65.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "2e0151f6c7551d176b29390cc76f4ae8bf353efd825de06b54ff244310f47358"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-65.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "020481f9587a955afb11808d81d3f52bd35cb43488b18c5b7362e6904b4d6062"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-65.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "a87215bd80a9834d7bee7874c1d63e1749b915b295e4ba67ecd37c35af0ef2da"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-65.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "e0241803eddcb7897ffcc0e21c693e8307b2ed746e46e9106c7eeabf214d7864"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-65.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "47fd9ae618582c3b99110c575016bafba13c625099b25f0283094f7785265e72"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-65.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "a5dc02b8ca7a15bcae72f6075bd2162f8a910ea3e0cba2bbdd931c8c7f1fe47d"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "e2d4a5fb3d519b6c9aabd755643a7044f735654834eb1f74c5f0f6f92b7af6a4"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.5/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "68d7096db08e815f5c7fb1fa5f92c6b0b2f570cf52a9446e8c24a556ecb96702"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.5/sdk/dartsdk-linux-x64-release.zip"
      sha256 "4342ba274a4e9f8057079cf9de43b1c7bdb002016ad538313e8ebe942b61bba8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.5/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "0dc218fa4defc38dcbe4806f0d9d4fee9f73a0432f2444ae0bda7828d4eaaab3"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0f0e19c276c99fa3efd6428ea4bef1502f742f2a1f9772959637eec775c10ba0"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "b4f326bd045aae1d4b00a6a74b11d70937fc41291a9d8d62a123dab8bc3ac7d5"
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
