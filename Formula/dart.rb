# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-224.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-224.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "d3901c81881a362a9b45eb8d0b662c965df8980a03357b645058eebd487ab06a"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-224.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "15b16d63acc5d310f38e63057223bc208bb675825249ec7112421220172b1ef0"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-224.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "c618bb1aa57b7d68ac1efaeef48dd9be204155d44c97ac692e5eb2653ccc3f34"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-224.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "4a0381ca5a73e4808d28f3819e58653ed98c63926b77fa208115aea2e3e91961"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-224.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "4ec950d9fd12645df3d5f86fc620008b1dcc82c185509c06da9efefac48fd82b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-224.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "d58742fec5cc87c39369085caf7223e1f13f4e1c18840f754863a21d9358edce"
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
