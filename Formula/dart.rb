# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.1.0-174.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-174.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "7dfc0dac5bd2301b1cde44dd4785de9a62b1590826022fa85fcdfaef52529585"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-174.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "688052e0b62f5b120729abe2fe5a9c834fb4803b6a8b39e64a0d7fb51ce69fcf"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-174.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "14bef942c86e78166ba557cfcd4bc42123499dee89189de90c89d31e92d4b904"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-174.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "9dc12b864560bef6e16031b7f0bd16408a5da4654107dcb4fd3da5aaf0667245"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-174.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "6a642e19a9e2d3be2ae08e36a815d934160c4157fa6d84a88a15f000e211921a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-174.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "d955bf4bc90a3bbc2876f376a8bb90cc475095c20e4afd00f287c695bd0f7d27"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "3828de27699624d6d336a29c76ebb6d03a906fedda6f1ea69cd2357e39d1318a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "24e5b5613fe5da342ac942339d0ff9320a0e5630ca94552b5c4236a09735da11"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "c4a2c9fb66096680bc99f687343ba9c64cc4f8a9c583c50a71ab8a63339303fc"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "75d0a26962d449ed30e47bafdb2696804344528eed0c3ff9297651e510cd2118"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "d275012238a7ad416b819c74f303b152d676a82a97c3cffed01dda2915e38a0c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "e31ed76eedd4daf202c54d6472a4603cd60fe17d090b5e6782b18bb7b7cacee5"
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
