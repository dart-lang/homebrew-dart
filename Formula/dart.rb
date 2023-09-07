# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.2.0-134.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-134.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "d8d2f28fce60273d6a94f3cc20700f1226d33f2949e33015d28e6290c5752189"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-134.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "22fd9dc966e50b1928ff7437328e2a563517a31af6a902d3288f0661e611a6dd"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-134.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "f5f8c2ac64f6036cd803953343ccdb91b0a3d5d8781334245264defc507e3b19"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-134.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "855532c8779a638a7b21d51650f655c556b2d828d0b3988ed80121f7f4ad60fe"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-134.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "2cb230883ff63c32a71f4150db767101fdd5e1eae93160eef1386ba47a7c9705"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-134.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "78a6412b04fabb7d4bd4aeb499c5e2d59d69e9d90f5106e7807f41cd45f317aa"
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
