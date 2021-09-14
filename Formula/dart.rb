# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.15.0-101.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-101.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "a0f0988db376d102db6c9cf2023a30a285a308f754907fd1cea75a78eb9e635d"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-101.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "9f6b2a4137c0f0f5b0b0d85a7918623592978ff0c0e2b50edeb86bba7bf2c523"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-101.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "9161474205ab97a09aa82f3d91fe38b3423b140c2038a5cfdb870e7d1242ce2f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-101.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "bb385af870ac12fc26042a941c701d4de10a340b1de8ef84d878511e2654c3d1"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-101.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e8d2404b0a024852243ba7c75cd35232f7fde41176ffceab5af34688103dd43b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-101.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "34a6db67bf3af2298613a05e3f9c6c05c83d93f7f744f0c89c60df04e141ba9e"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "bdd35a96c3162a1f9a33575b0b48ba7d67f6c87dc6718b5b2e7ed59070bb141b"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "dbb8406abe50003f41872bfe297cb0808d7f5c131e4abcf7195ccea185579d58"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "a615aec227431a6b15dd77c63904e505ba6b2882a48d4efad8fb20efe868a740"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "132d57b773fb81a2376490d8d3885e96d1ac18b87a4adadaf80eddcadf4ef22b"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "fffd5f6db2537d2e2e91ebbbe0261c4e91762849f297e7ce5c64e96a8559c090"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ce209720ff628c737067be8e55c86a3cf0257931107ad46142680c1d59dfb4b6"
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
