# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.2.0-90.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-90.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "1aa167eaf4c00a98b20504e6dd6329c6e83abd83e43fbe3509374e9534db8f47"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-90.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "20f8df7ba0a641546ccec107fdbf1989fe03b48c84069c6b09e109f36c891745"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-90.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "50c9a80ebcfe7f162cc5187fc2119836ed182eb4d814a6157d69f3aa75745ce1"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-90.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "0386b42770b6f865f68b895236ced8c95c383088e8980148cd81cd3d45767c3b"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-90.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "c2fd8032da9a28e3be9ba3e73f62c0946d8c41ee1c654836890bda3c53b0961c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-90.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "961da644bb82b792875f8dcb7f2bde91200851a66e1f5e7d82891ad859940c6c"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "70d6804968c116445386904801670c8804d7c01e71e714b0c8fd719d8d34b557"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "af8b65c540c1e9c3e2ca6189442c1cdc2e7555f2bed69c9767e27404ecbd8f87"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "7ce5c1560b1d8ea5ee0e6d44f1c3e7b804ddc5377b38d72fe4d43009a6c67e84"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "471088e500cb8f772354819e3b929e07bc2b537b319592e7fa4531fb5830e726"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "fd4fcc05f1d1c82fd618b83c7d877968460c5bd425774d89add438be12a20795"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ac5880e17b80e046d59eeac46a77d084a8937804dd4a4564a26c53d453df890f"
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
