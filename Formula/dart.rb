# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.16.0-80.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-80.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "472f02f6a26abf869490dc6447dfabd4786a55d67d6ad9bcd192397ca370f2b4"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-80.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "170cbc7b303433c82b90e63ae68f95d25142d381204c395994a9ea4faeabe1ac"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-80.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "e62bad19024540a641f463523c952e1ee95883c1a5cd861486ccc72f4614cfab"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-80.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "66d52ff24c149dc3325cb7dddca39d601c145bdf055eb3dd36269e8c4c9a4bdc"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-80.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "b9b309a529c1fbee4ea3b0a2b5da45c93dad178332d0370f8d259c1bae99ee1b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-80.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "87b4f0e4eeff27a4544757d373bc55ca23e584369ac9b3576327884146a00bed"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "dd01b724f56c1dac2ee10ef47eb5d5ff7b2b872a2847b79ed671b180c556d17f"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "a781b7a2db86aa4699d39f39f6cb8695705a0b7f0af8113514c2e89fbbfd77b1"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "53557538f98578d642741c45cbbcaa01b004d1cc61f5fd94a8a426ade26ef580"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "d287215a54eb218325c302ceda2d462090aaa9774e4d5d30aab6d9684d10e3c8"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "bfa01d1842fccf9e59bfed8edbb3e43921d37b04d4cf1af6a6895e3bc6243000"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "22e112cfd0e99bf54ce000a55d63017e322bac9e810b61195d701c785de897f5"
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
