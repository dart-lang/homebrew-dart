# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.10.0-155.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-155.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "5509a3e3d4202b5028dbabb6f64e19dcc3987f31e83e5b1bcf5a2d73545d83a1"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-155.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "3bcd0c6a501b471945020d15ee9efd1342f9c17244d0d8db0fdcdbf53f712956"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-155.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "45696276c5d69b599f545078a59505c0a3d0dd8bde95f0ab7a022695e4ec4bfe"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-155.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "84a8551c36fafb1e91c0ea7305457bf52911c67e9bbd965d3d2cb458823618ba"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-155.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "bceb43e5238110c42d78de6209c75cb994a30c40124d7f8c6d937efe84ac3458"
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
