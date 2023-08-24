# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.2.0-94.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-94.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "b29c3d5afbdeeb4445f7f3e0f80148d1295a68287ca49ada2a4c6f767606ae73"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-94.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "aabe93239f77984bba1823ebf4ae771d17de5fcc31aabb360fe263462ae709ee"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-94.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "81cc93a4cc489f0a2229fd756b9da1d23397fc3b5329d7ec9425589b8f262b29"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-94.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "3da7b23e7809d70263effa3166474e197ec72ee3d17f4a60ac38cedf304bad20"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-94.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "884ddc5f35f3e5c5643315e0dd066f633348cc4f5f0f3a24e7403e790ba3d12e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-94.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "b01b53923e08e2c5ecdf24502d9a669144ec456d858537c690c29e98fe22e4df"
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
