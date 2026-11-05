# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.15.0-118.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.15.0-118.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "5996002a57ca304e88819acf465de48a1f6dab8e548516d832d9f0b57b81f24a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.15.0-118.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "ceeac0e2b723347d027d18a28d1e2cee3d3ab0fadbc374e0db9d53409b789fb5"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.15.0-118.1.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "0563232981f3b0d2ffb03430b0627a7cad7f5327ca2caaec33ec6ad9c3a9c774"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.15.0-118.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "32cc7c1451564b281d993298a93b32981bd095e5e1d9a592b47a61c5ff44d910"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.15.0-118.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ec1cbe21c8d1e45a8ca9b0e3fed7e566d2f1e0642c00017eaa974a8b67623e60"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"].select { |f| File.executable?(f) }
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
