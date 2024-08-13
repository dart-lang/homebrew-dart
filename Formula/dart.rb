# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.6.0-139.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-139.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "91a2c70e13f4a5d46924c6508c346f6fbd7042e4ed22c335b9bf6b9844d1a7bd"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-139.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "ac81674ee4efa5e7f56e57a148c8294edee5c7b34198be978f06ce59b8d70381"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-139.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "dba82d9584c0a6b28f48953a8096613d1ac886359269164eee4455058bad3479"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-139.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "9bb50418dfef78970954a3d7efcb2dc1aa6acd8b4f2a855be97fa5f977e7a791"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-139.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "1145eae0504702e649e2560e5aa901e027a3c9d57f9b5e8937dcfaaf2133872c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-139.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "20ec48565b9237b3a19eb19a8c830e53357d9f14ce1d7e14fbc79a94f35968d2"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "68e6746c44eb4bf359e5b57f140b555f3c022536c58d3951ccf5fe8dc4011c32"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "730978a02a6d72b8a2e05ff7a6ef3dc34aa214ed7a1e79e06913ea7bf7227d94"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "011a1dd6ff4e0bb4a168f7b4e13063514fbc255dc52d1ad660bf5a28773e9773"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "13804762f99d2d80659a9850f8dbbcbfa6478ed5f27c59c0d12c96208faa9db3"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "ee2cbcc36a190a883254ddc28ef772c15735022bfc5cfc11a56dbaebd5353903"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "dec85f8439ae55f30cc29ad80b6486acd20c97b25dcaa1b3d05caab36c980323"
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
