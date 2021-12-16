# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.16.0-116.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-116.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "889553e349a1722d3327a36c66a1080e5d8f2570c60fc17794afd90e3d10327c"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-116.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "7f90cde8ed546ae468f97e41930e90b957e446b07610d44e7392654860f751d8"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-116.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "12f1f7bc8b7d47fdaab5db420ff5640f1f2f0ad37eae7586e291d4b410aef528"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-116.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "d5b9ea2cded6211fb5c65c04a4269ef5bf283c8ac6579a5250878669f8bd7389"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-116.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "90fdcadbd1065c26a198aabebde53460ab83cf900c8363d51ccc263cddd51ab8"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-116.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "ccbc7876249089f73e57673290ce25d729e384d14d7aafd149bb0ef1896effc7"
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
