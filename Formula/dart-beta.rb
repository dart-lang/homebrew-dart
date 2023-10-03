# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.1.0"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f8de231b80d74c211a6849d20326596042ae921c87f31d6041c0f9e3858cbe48"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "8b2cee0df8199d6868b3160ead16cbe463434f0d6fdf4ed15b70ae0d17f6c120"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "32576bdd5c061b7f34557edb08dc85419a184839ba314a6db69e10e0b5a0bf83"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "de22241dc232c2c396a60e36724e759c1429cdfb0414c41df36730042e2a9b19"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "72d2f0771764d99c22691d2b487eb7656db99f91865f25be908efa182ca18445"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "b729d37614afb7744eb001d229546b50ad833dd76c4f1336de274ad2ca163120"
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
