# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.17.0-28.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-28.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "c44555f867e69ec09ebdba06721911906e206af4c7a971cd241bc31738cd9d46"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-28.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "1e633d08a1ce5c34ef34665cc4bd18821aa71b0fc27b503d8b25e969038b34af"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-28.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "ff7edcd2633422dd3af4d32b9b36a00c012eb4ba1ce0c420b8bf2fe8ddf4986f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-28.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "946b5c3d55acb42db147b4c68b09b184be4c4f49757370b28fe876605e50a01d"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-28.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "544b57699605da2ed7bc037d9894535056608e215378ff5a395b608589c2d11e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-28.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "71673df86abdba92274ae2ae98b2e459a3a3e5c3df3bcadba635380b9050aa94"
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
