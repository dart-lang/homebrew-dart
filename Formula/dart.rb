# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.15.0-82.0.dev"
    on_macos do
      if Hardware::CPU.intel?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-82.0.dev/sdk/dartsdk-macos-x64-release.zip"
        sha256 "2d465ff37d8d6b3260326073e4b32d0c0a5eea09d34e26a1b655fce4d657d84b"
      elsif Hardware::CPU.arm?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-82.0.dev/sdk/dartsdk-macos-arm64-release.zip"
        sha256 "cd8039a9dc1b515810cd4f0cc1019848b0bb553fb947d061b766fe84aee2e38b"
      end
    end
    on_linux do
      if Hardware::CPU.intel?
        if Hardware::CPU.is_64_bit?
          url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-82.0.dev/sdk/dartsdk-linux-x64-release.zip"
          sha256 "56fb35ce1464b3eb4807c1658afaea410a668381600abb4e9cd3ba83ab29a741"
        else
          url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-82.0.dev/sdk/dartsdk-linux-ia32-release.zip"
          sha256 "a79e2ce0491d16ce198207fdc9f82e90d72e8587fee85021aca2e63e13e17550"
        end
      elsif Hardware::CPU.arm?
        if Hardware::CPU.is_64_bit?
          url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-82.0.dev/sdk/dartsdk-linux-arm64-release.zip"
          sha256 "d37c30406bb3b55045dec480f15bdff748c839bb3f58895751c665ebdf7fd0a2"
        else
          url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-82.0.dev/sdk/dartsdk-linux-arm-release.zip"
          sha256 "cd4d464d0cf7bc13c28e3851f9dbd50291220a402e2e06a330b4a207102cbebf"
        end
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  on_macos do
    if Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.1/sdk/dartsdk-macos-x64-release.zip"
      sha256 "bdd35a96c3162a1f9a33575b0b48ba7d67f6c87dc6718b5b2e7ed59070bb141b"
    elsif Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.1/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "dbb8406abe50003f41872bfe297cb0808d7f5c131e4abcf7195ccea185579d58"
    end
  end
  on_linux do
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.1/sdk/dartsdk-linux-x64-release.zip"
        sha256 "a615aec227431a6b15dd77c63904e505ba6b2882a48d4efad8fb20efe868a740"
      else
        url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.1/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "132d57b773fb81a2376490d8d3885e96d1ac18b87a4adadaf80eddcadf4ef22b"
      end
    elsif Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.1/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "fffd5f6db2537d2e2e91ebbbe0261c4e91762849f297e7ce5c64e96a8559c090"
      else
        url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.1/sdk/dartsdk-linux-arm-release.zip"
        sha256 "ce209720ff628c737067be8e55c86a3cf0257931107ad46142680c1d59dfb4b6"
      end
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
