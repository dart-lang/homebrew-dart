# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.3.0-246.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-246.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "6e4d7b04b6131963539639e3e382fb0ca3d189384e56275eb27220e9271bfca4"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-246.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "90cc7588f8a1aada52a7874f30da211553202b2ce579ffa7c2730c7679de0f69"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-246.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "439b0c5d0774eccffb09ec84405685eb7d1c4ab0f2207ff6b86add0ed7d8c457"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-246.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "0ad53d2d44516f652a13c991ad48cdf59cb5a687ae88b2133e07758a7cd107b9"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-246.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "c711a28fc49319a4a8b0e004c7542266ab13fd2f093344d326b509d014ef6d79"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-246.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "72dd68a6661cad4baaa2ba3447cf1c411e448a92e9bd51ba4b1e1c3106c890be"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "716239fe2fc0237e5a31446ab5e3c95a8550a6bd7d5c5ad404c2dacd3aa4953f"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "a35017cf51e1e2b86801fd9e0937d7690559f096631b57134527f51f2d6708ea"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3a1903a8743422e13e93fb3f497c179fab5658ae32b9151a7baee3158461e0a5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "a6c19ad36fe3a58934130bca0e0801c9addc692aa2815b4bd9dda556c38859a1"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "dcf3c8116070c77f2376cbbd5229712a4e6874ef66438c0611e2ef23f69b2862"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2bb8a9faf7de11294c6c0f327cb7c328357f8872a5112e7d3abe6d35bc5d8199"
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
