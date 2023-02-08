# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-187.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-187.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "ed3a9e10ba8b77cad2e81aac3033cb6688c986249b96a7068de9672b308187ee"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-187.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "15985db5206b656ea66ff3ded98d82573407a865269020937eadf2482160d18f"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-187.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "1b2995745816b817a2b3003faab9e312b06bde15349da3e9317017e56d16f5c5"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-187.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "5ad3639c30b177491abaaae9bb71e02278caf859f395cb63960e7800a4bbb48e"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-187.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "c496368a0aea5d485c80a94445cf92325237567f048a3fa6d1d29f11b2cd7dc8"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-187.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "61d4b57b560d61793e931d80d32c532dec9b56da56459d70c33ff51e9451ae17"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "ce307ad4f711d71ed7199ce4e6f3b2b2c7456b3b26a132023b8b960d01e1a78a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "b373aa4f838248d2c4bddf4774ce14bac468e621f8476986739526d6295bb26a"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "326f6085aaf3a6733f3cf2eface18513afbd07c70e4068c4da9c6880161ddb2b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "2be2031d600b8be3c73ff9ed56c8b2c304c5440a62f1e5e3a15446e76e7e3471"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "4c6f5139bde79f557af92790d219e64f1a2e043a657848e5618efbcb82f9b77e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "d3fddaabce691a316a2e3eb8c51f2bd46f53f073cf0e38b525cfc404f0a0d72c"
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
