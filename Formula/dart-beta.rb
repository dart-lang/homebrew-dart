# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.15.0-82.2.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-82.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "e68574b7209a0ee63865d123b57507d209fd3dffc74e6218ac90ea3ed495bbe5"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-82.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "ec2f3d69c6df78cb0d9bc6bfd9a219168914f61f51d1736655cf06ce55345b20"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-82.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3f23b4ca6d7ffeadad21cd69577eabcfb5d872cbd005f04b5d4f58c1866dcf04"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-82.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "678589511a9a5b292d90bbcdbf569795d71e5d138f445b29dadaf62290d826ee"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-82.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "00ad354ef816d39bfe046a40c567775f1b758aa19489e153c3c4b840b1b19d57"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-82.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f94cde9c6286c8cdcfee943d2fe75677aef781e5934b80ef740ae0a9eb08659a"
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
