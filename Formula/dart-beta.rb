# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.8.0-171.2.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-171.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f62e2e493e3d767b403c1a74845763c0739f74547632ccdacde3778df204954a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-171.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "4e30c7953a5b3e97bfa1e238777cbafa608152f05911809ae9d935c9c50d2e33"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-171.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "e7d9d48ac0a97a8265d338d71cabd16d53f87ecb96fcb1d8d327e89560cd09a0"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-171.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "6d65374a0d767edd35afc7457c2d79bd2700df6487748540dce030d95a99fda0"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-171.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "23f2528c0ce40f5fc1720af97628a7dc78443d9012df4022b791972acb28646f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-171.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "90309132fee3ec78d790a443d00ff1a5d2bf7a7acf8c14b9ad3ef20c8da2cd38"
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
