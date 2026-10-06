# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.14.0-296.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-296.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "0630f019ce963ebc37ad9dd6f16186e7f18f4f8098813fecbc62d94129470101"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-296.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "f94150a6ac0ce9aa516113a2c03cde369c939b8f0a05f22b00a1d441f06a9182"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-296.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "d9c134f14e3adad671f8535e89fd8bfd977cad025e78111ada77cb293ab7c00b"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-296.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "0353031adb6d10a9f9ff06dcfa531f2d1c538594ca401c00fa8d911503f6ac1a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-296.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "96154d4a45d7a89d3bb4079963c35e4a88bcd9f85be247af9fcd3e9d6074cee2"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "15aaffcc5c6aebcf5e907f721671a9f03cdc5e0b95affa59a9d8291fb2972421"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.5/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "9dfe7d6f2558816c2a978aff6c80e8a4509c6cb726c0702a616c64d286f60e88"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.5/sdk/dartsdk-linux-x64-release.zip"
    sha256 "ea864bc64df30a6b8bdf30b2e32550f7717d9a890de8f40293aeabb924fe232b"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "19a731647c3ed55058ee46dde00330150e6a8729bb6121b4a31e86084c8a3e6d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2c33146273ebc79e46bc06c9d46eaf1c9e36e25a361bd919259b89d231889f91"
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
