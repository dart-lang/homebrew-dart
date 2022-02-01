# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.17.0-69.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-69.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "dab8c79f40ee48bb88caf389d60ef1a167583ecd75cb6e93bbdd890cc9a80539"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-69.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "7d23277e5add7e15cacd6addeee87fcd4a21fc894c85543c32bd90e49ff9e07f"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-69.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "b33662233081d04b4f5cec82d92dd5ed4316fe87abff5d3708cd8a4c76665925"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-69.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "abeca6de7e524612e1e33176ce1f8948ef1099149778ce211937514be09c4436"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-69.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "97d13e4f0faca7768a593119d06292322594fc5610a336455e9d745d0de1a229"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-69.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "dbda9b6da0200388fd8a957785018cf276d3090b277cf000742a73c40a2e55a4"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b3a6e4c21da6e4a751aff5b1597c08b4ef58683a69fc7237c639d2d941e637e2"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "0c31380e90369bcc0a91466e4039f83695d5bed689eac20778a36393745ba581"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0f45dcaa53b4090b69b277b885ea9a4cb3a41589c9119113e1b978ad55ce335f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "491ab94edc52f9bc02a95c5ad14d99867f09d56b66e0e9eafb7b904bef79d6cc"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "8836c294234352cc53e8aea4a1ce0442ebbb769a536ce7f309579da5020a2395"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "751935fc08dec2121410c3f2f33de8215d8a4e5f21192a4c42c4b81dd00f8659"
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
