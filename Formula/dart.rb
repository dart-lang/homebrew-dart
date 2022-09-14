# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-173.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-173.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "b97c538f76821217dcf3f8ad25875883e3d6a230e321e748597b07ad36ad3aba"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-173.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "899c034121230cde2a90d2b3cb9b4cf4ded4235814b9ac2b447f227b23c62cc1"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-173.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "bb9bed8d193c5557f617eb4b89d4aee5894a806d5560157fbe6f5142ac1fadd0"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-173.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "0e7910eb0ae38be6ecb14d2b259608c2c2f87ef7b91a017f6e1299c7536ff46e"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-173.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "08379b473b7b9fd60ebafee20e4646053b0395e3d2eed49b243b93802a1ec201"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-173.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "ca5fc188813cda3de24a0fcca1882440a1a4f8e703e135eaeab426a845a05357"
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
