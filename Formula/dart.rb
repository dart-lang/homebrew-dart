# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-375.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-375.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "2439349492d123b99594cd511626ef9bdb698cb23ef68e8fd27818acba8fc805"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-375.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "30931bb164372c289bf3c995b1b6fa90d388907ebd4176d08854d6ac9aaaea3d"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-375.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "dd8d40ff3150b35e88531b4436a4f43671bf70745a91109518d90d353779788e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-375.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "0a574a1e60d587ae540b2e73bfbedaf42a8f1e8cb586a78b089c52b5aab33291"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-375.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "b793e60256b66deccb1045cf9156874ff099319dbf2c10ad17cd72f44ccb9125"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-375.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "ed6904ad4857413a0f17d85dcb1b53ba76f625dcb9d3437bc26a678807d19491"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.6/sdk/dartsdk-macos-x64-release.zip"
    sha256 "999a66d6d67aef780a5cf455bdf551133587e79e7853a962412e4c79affa95da"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.6/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "3c6b54b6f44bca38bdc7858ea45734f297951eba5fb10c8fa7b86b4a3f43edb6"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.6/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0fdff25e6acba3d6094155a7e341634f8de3477e86c2fda4ad47232c1adf704f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.6/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "39f0642199b0ee376935ef81cdec24b658c33965819ed704cba3e6977efb3e0a"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.6/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "6913b7c0b3b78bc141d372cd473da21771e57372b1ab45c977ce1550c8ff0b9c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.6/sdk/dartsdk-linux-arm-release.zip"
      sha256 "7286b3a935c98ec9731c6e540614ef20e8ad8a1d6bef194c79e29d9837363de3"
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
