# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.9.0-63.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-63.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "c216ccbff5c3c59ecf79a375f06b9129688878844c96f3522dbbd07e2b0b286e"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-63.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "2f14b44224b0d27b03659de9232d5b1929c04f0a92cb9d0dcd70744d403d0520"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-63.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "acd955f3297336abbb99fa1350fac10d6642198fcb9b632fde9d0a53cadc1103"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-63.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "fe75293519d4fc68855012b4f66204160aed2c1059b634dd54b800eb644551f3"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-63.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "3b66d941bdc7dd08c5f4fe378823e8121efafeb302df900c2f98fa144b895129"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-63.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "4bf428a1b1f6f6a54b9b1ae76675430851f6a52fce78aab36a8e19b1bc104560"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "98a83e7f279f13c0589403cc11cbd4b75b9fbad89ddb5c2bae7a259b63bbe809"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "eb6479d1880185b351d7fc1382a460417b140a9dd6437a67a969ef69d3fa648c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "b772a2807d2fcf08b4edcff998123b0e87391c12067ad0cf11f7c50ca31982b2"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "8231834c3da17d281d0ff96d46ebc237cdb2fc7858f1b3091c488376724141b5"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "16546f4cd27fca883eee7f1e7597f409a67e0254174443aff6f62c35c9ff78ad"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "c518909142c6c3110ff8818445d2359103deb20d9136188c8ca3529403b84a4d"
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
