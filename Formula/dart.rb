# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.13.0-38.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-38.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "551e8ff7a1c087f39676024b5c3e68f9a2fce1ef14d3b98ab59729164d5f99b4"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-38.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "041238957566b82b00f6740656b4ad6f276e8e2d8ba2b53b7230ed3cc151c731"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-38.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "09388a1a34122755923ae07c2b353d333ff849e09d96e9010b0dfcb56878a1e9"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-38.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "0330a4f93ac8ceaf816a25a5f0c2a207c85e1336ecaea8f0f2bd37b5ac68c1c6"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-38.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "7fa08d97ee0d952f8136e76ad209fe5a0a9177128a69729d170244810a98ab66"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "94de6a18049c354026f5422446b311cfc96b51db6d316eeb7ca46ff14c0b8aaa"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.5/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "3fd03deb3b0c7897a9896c3f5f3dda4a9fe63c43b14364ee928ec6db348be0ac"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.5/sdk/dartsdk-linux-x64-release.zip"
    sha256 "57f3ab5ac24883060b1ff12bcdac472ed76563ec7364e88f8a6d41e4f0db075f"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "50e9aba58f8717943854778a73074e63a80c42054355d35e2732a0cc0824a2fb"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "27a3fd1eed416866171c833e98081d051ec7667d6c6f1d4a6d8f5637ac852433"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"].select { |f| File.executable?(f) }
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
