# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.17.0-7.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-7.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "b6976f8608e8ead162b440c2b7a66f23a60023771efdc7e497f049090d2168b6"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-7.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "4af5c062b0576d81765ae8106df55039898e019737262c990b9c92456ea4884e"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-7.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "693288858c030f82a97c3c6f38811720d8920e46683025b50ecf5f1184bfd9a2"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-7.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "0b73d23cf5b21a5c125e91fbc7ba871d38f806231f353062feb530791d2481b4"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-7.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "9fe11204f47cefa69b13b43a4a4179c842c2cdc2f910b5a7ae8dd9c8a037d5f5"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-7.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "4df230b1bfd5a0de1c72899dc6939dd6464574c51a0cedc4aa538e348958fad9"
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
