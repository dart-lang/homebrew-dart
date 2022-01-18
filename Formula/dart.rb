# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.17.0-18.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-18.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "12c03fcf6764ec6d813d72fbb59db5bd38b8a4a5fa12f6fe7b8c6ebe473bd11f"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-18.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "285b8723708c170d18bf526a2e73396bf1724df32b5b338b6843b1a8b2e8643f"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-18.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "0a5a523de8a0d4eb81edcb4e5e434de85722582081cf38344dd85571e9e72c4e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-18.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "c2f6ff374446d286ed1c47c63c920fb730fd64bdb8f64c758d84b49f5370c54f"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-18.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "d5eb373ee5203bc903903b1b7308812b693c69883d02775d49beb1109a2de9df"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-18.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "a1efc22e3cd16cf8d96b702ba2bd117b87b83cdcf7886921b46090b5cc001268"
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
