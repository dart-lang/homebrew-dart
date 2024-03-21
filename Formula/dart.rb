# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.4.0-250.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-250.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "4d8fe26949c87c90426b9f24cc0bd41061d49a5ebf88699c02a8cb113d9a5f48"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-250.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "ef56e34c05219a0d17b40eb071cb5d201bf12e9af60b755162c6d2dfe0db8f27"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-250.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "ad18af0a3d357c3ab5f97519fa60b18b943b685bb1e9eaa93051e54def76559b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-250.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "3c3f2eadee872e9d1f4f3b61828b8a2f0c7aaeb8f1cf994d4a06c7e4b3dbf263"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-250.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "d29897dec813a70e310b8a7434b5fc077b6b0c2ba51f167ebc380d14d7fde797"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-250.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "aa0e0a8e7f4e61ad6776a7de1ab05507092c6efca4ea1adb8a06183cf73fad10"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "537146873435b3f0d2a39cea421c958433526cedd3ab81afed7317e91c492446"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c7d79bfff7f8c929b50e5160af1cc4d5a0ea70f77765027086679cceebe2d839"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "2025a47313408d1b1be943b0ce4ca3d5b629f2a4b2a6cd8ea8c6a323f1693d1e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "16baf24de9e47858152b8a07e2d286ad5298b0d4902c9a8f23318accba8f92cb"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "a26b4f98e7b7fb6feb8abe4864ab5c890434b0a048220e27f1886b7435c1321d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "6a394b1206a73001193befa7aecbfb6bc8c8d154ed4d3018ea9fc9c4c321ea4d"
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
