# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-263.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-263.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "9d8e5d711495ff1f757eb122f8c2c69d2fef5634cd2a225f8c21f078be683874"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-263.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "82640ddaa4791e830d5d552b9582074bc58dad66d9077856aac5b0ae27e1c974"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-263.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "60626c59b2617cd795779d3e24da5289e61fdc35c607070cb726703ef0632f99"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-263.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "5cccedb7868c7d25244b3010541b9d327041026e4edbf0cebbf6a723e84117f6"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-263.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "23365e38fb844e0029affc5c7dfa014a58ad7f2673d6b112cb01c600943265c1"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-263.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "95c568e46e77ec8fcbb34e74af682f73122d0318348ed9b247a1f98b2c309059"
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
