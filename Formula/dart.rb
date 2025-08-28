# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.10.0-144.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-144.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "c8eff9e17b273f3abce74e8a808e485a2d8beef86a0d8d283b16a8d9d33fbca0"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-144.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "f583fca574009b0b6b984cc5c0d0524d5fa0885846c0f86b0975467b4be8a8f2"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-144.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "efe60a9ed62be9f8ec2aa1da551664a32d276de420ce342cc87cbd4a26f6b5df"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-144.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "4accf4331a4eed4748b7721566213671a1705a461cf55ace3a96a7abbab8fe0a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-144.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "fdcb31b06a859ebcb1e32ff429fb4d18b26644ee1bcdd7f6d2f532560f27a5f2"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "4c67a5e8ff687b0e5aa3c0c0312e640b12e5d5e9278d91bb25cec0df66287d79"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "01d0672db82666f72f9452df38ee1516a72cd9bc29818bd3eaddf82e40556152"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.2/sdk/dartsdk-linux-x64-release.zip"
    sha256 "ec22e81271582def81d3e10e2a555ae5d3d81c6951465a3d16cfc47938e9f92a"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "d62f75f3f1bfb44a22fbd5cf0a5b47c758516ceca5dcc7bcec88896e2583e7ba"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "6b7d758f64ec94af2933a0d92238339eb9e179a0d61ebd4f9095ac675f4ad263"
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
