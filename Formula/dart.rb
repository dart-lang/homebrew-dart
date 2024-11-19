# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.7.0-157.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-157.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "7491d47d0555a5f4ce4bca72fe060bebdcba4ba25136667a2927694f327e6d81"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-157.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "a35384b987ba5e2d2eb65a9e302a403ee9a74c9b17bc4c009f5751906f6b0b2f"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-157.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "5e987e34890c3ab3db227537b3ac0210eaa25d3f6339d2e435658860a8a035a1"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-157.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a3dfb86ed7d083acaf0ff0e9f0564b93b2de2ff920539a33b29ffd0a09ba8a0e"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-157.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "df6ccf5da9d653bd71e4cb88015323c87d8d9061b103138f67e211805d0e0aa8"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-157.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "4f82c8c4d5af5eee04945a6c111b0ee5544dbfda1223fb28c35745d64871a1df"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b06db3f3d0e92af0939ca467e87ecababa96da4f9fe5031a788304b5df949374"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c045940e0f5d4caca74e6ebed5a3bf9953383e831bac138e568a60d8b5053c02"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "8d0c5e34f2a9d6b9f5ebf05252ae1703893f6087d547c631b390aef2d0cd6967"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "2f90a98cfd45427555b06aac813f70573ed5882a512c3f2cf1e732ae53087b0a"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "a91d64dd3173349cee58c82f5ebf18bb9670f65eecc26d5684124c3def3f83ec"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f56d635ae4119f78ed887eaf8fb5e7821405fc10816d8ef42d3a9105c7ffb1f4"
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
