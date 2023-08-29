# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.2.0-114.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-114.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "1546b53d57c6a45ede15519d5baa045bdd1b0a7922451f6de378d5b7952a2c45"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-114.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "960eec70bcb3f71d857cc359725e38d20e35036e0c448e568a2a69f75563da98"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-114.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "0c44a10a72746de64f3216d5142fb885edb8a77aaaf11e6d8ca544ba57d770c7"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-114.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "90c9a5501f09a3030256220703d4d97e7e57467ea4e6c866130b25bbb79350c2"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-114.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "bbe5195119f520a3ec8d868c6d44aa7b28ab046239e9fec8078945f62192f01f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-114.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "2026ec4e5147bf64a3eaf188684037bf6f2f89511a4cf1f9deedf155079b9e34"
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
