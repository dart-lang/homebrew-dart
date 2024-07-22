# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.5.0-323.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-323.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "cd1ef6ace28f4e7701ce30a8ee543c8ceccaf1c3d996cd0d11aae9ab7e497236"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-323.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "0e2c819426052fcde091a7c4bb36e6e4e1d2763fc683877604b20dde5288bae5"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-323.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "4b709ae837cd82f00f8878adc1f73642e6de1745f8b0e1144b5fccda17fc6dfb"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-323.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "ab4d34223db70a279bb5d37588f14a989985c0132fbcf68eff0463a116c567f4"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-323.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "1fe641a95da21032b9f9021a9105e717556c3cd858b4b67b97f52874acaf3756"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-323.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f37fa6719f102372ebe06ff13b52354a0113e1a64e5e1a48cd3b6987dc15604d"
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
