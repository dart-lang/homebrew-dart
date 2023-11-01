# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.1.0"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.4.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "77ed7d34132058aba9de7989fc513f97bee03e2fa1ac2e34cc2695158039f613"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.4.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "12897b5368edf4f5bc2adab24a20cddb5fb56d5928d161613ba5db5645fc489b"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.4.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "345fc18e2c2ab39db94fa9da34afb7d2f6bc7dff35cba66fc30429a68b4b52c4"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.4.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "db85a4bdfd736ee09aae99db2c04be6babedb9f01dad2de1ca2885a50f0bc949"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.4.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f2592ee85cab72c74b20e0f138f3acc023e9dc0e04e6aede25dd97ed78311873"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.4.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "b563fa1e44f847b552417c5a651ded4a508fc3379916e1ca2417bd0cdc5b61e8"
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
