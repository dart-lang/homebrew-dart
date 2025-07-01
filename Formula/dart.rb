# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.9.0-290.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-290.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "4cf117e860cbbba1c4de87b8eada8eb9510f436107d87e28844bb1abea1cd271"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-290.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "4d0dc97e005de60b69a88142cf54ec5f4272f2c0553596152f500a4cfcacb415"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-290.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "07e8ee88761fdada9872fe0630a60f9a7860679a1b2d74d6e5dc9d925e7906cf"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-290.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "155762a4f7750c2ce6c3f2ebd046b3403217f714a8d385015fcc094441d71969"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-290.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "4883ecb2725629b10f42312e5b063f1f90066e91ab81061bd27e90543b2e4710"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "39371df3d64f94f5b3d9c1119c3f549164c5628c6a13b9451b7b44859f1f9114"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "5080bc6f4a78ccce0e38e71e46476c08d61e081453646948f3f0c77177a928f8"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-linux-x64-release.zip"
    sha256 "0d58c010a361f3f1588b1c2f57942f7ccaf7b7abbe03404fef7a102eb638f09d"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "78a3240097bee3b79b009c69ead22e1aaedededcbe093eaa980084c5661096c8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "02adb724b0b684573f7630b3d79ef729f8cf9fff561f5170bcc195ee2477e1e6"
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
