# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.19.0-255.2.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-255.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "99e24ed841b1ddec5ece3ebf7fdd5c95f284073094512a100dd97fd590e92189"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-255.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "923fdf93daf6385630e96a3d7853396926d7260a228947b1d71d441727bb9088"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-255.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "1f7f7ca69fde326ec7b67e2467581e174feab05d8b565742af70a33eb4d9ee04"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-255.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "393c6a7f04e5a780d01febaf17ae8f4cae3099fc33d0c03aeaf7c7d5e2f59955"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-255.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "8fd51694cc0d94fd393669a8ada893ca76e4097eb2f32fc3a95ceb8a4204e437"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-255.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "efb811288c7f5f1ef52284a85d673ef023fa34c9ff0845578425b4d72d74fe64"
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
