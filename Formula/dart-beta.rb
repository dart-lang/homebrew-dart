# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.13.0-282.2.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-282.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "028f90835114717b3426cddf65ae7d8c1b6dd354b4c2130b32f1bfcf370a3883"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-282.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "076e463e0cc2495a4b2a771d8787c11e50f836d421f10505353ae4806a54d409"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-282.2.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "285beac28ebc4a31dfaf3d46bfedd6502d01bb3ac16c3d69daf73d44d367cf89"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-282.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "3c80a4d4b1a5dcd042eacadf8668b42d05889a05462f409e967035cb0ba3ed3c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-282.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "d74cb8c8aaf4f75f9eb75fc1f3e7adff48cffa63ed1a0074cddb54836049193f"
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
