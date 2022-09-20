# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-218.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-218.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "9e3c903feb766c549797a3f327c40c25d4167294af38f914655d1694064e65d1"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-218.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "be85ebb7465bef8545f427b77ed74ab801edf52cd22843ceb4f007222bce75c8"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-218.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "e5659f633b47b0c6e960e84cc9f44ff6a67819b1e8926a8c66b38c24edb37ef1"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-218.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "6a0076b0de22f1591da6ffbc356fdbef3b25eca06516e172c6697560d421167b"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-218.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "8739a0e3133cc0d2e0d5b0b3c0cf6f75e439ca5a2cbe6be8fef6712d44a7446a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-218.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "c9a25fbe516e7a337f5dca4e5aac8160f0093fb9f1f92b56cfece8509846adbe"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "8a0f851d1e33f4e9e16af0b4427927177f26090b3c147bb8479bd51b31ce2110"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "d5bb0c87189578fff11b8a320d159bcdf1a1ead1f47e23bd509308dadf11fa9a"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "7369fcbfb3c96ed85511224580a8ce0e5ecfc8227af563d396ede2055cdf84e1"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "9ddcf72e06a71494748b939052f323f7d7d18c5e9b269517f23f474b5a99eb10"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "1c8d96c0b718873f9ae6d9aa7d866cddefdb86f8b1584cbdf589670d65b7c167"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "697361b627356224903e9e4fe4e9e2600a462c56fce04f31efbcff6a44ee47b7"
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
