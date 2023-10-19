# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.3.0-35.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-35.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "ae9eb6d2bf3f0d7fbe84e1fe7d4bde093e2b0ddb003bb9910b0a9a6ad86e0fba"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-35.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "66517e9bb4dbfe50d2db221209f5fc16406b04076a51b3920a79373c44da7d88"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-35.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "4db73a884dc0c11dec0c0499a2ce237af5840c1507416f5a6a34eb06c4c976d9"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-35.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "10f8c3e8da026ee6e65114cac5d2fc511cfc03aff5ec40385cfe322013584085"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-35.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "88c433738813f919434420bae8205023e44d97c21a3c7235e5a7e88a9902dd3d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-35.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "8c914b4e378a2e850ca8bb701a9d9d25461a3a53c7aa8f326da2ab99c27776ce"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "6e6d499cdaf48a1b0c52285c60dc9d27c38a14612f49f77bc5d9fa0679d40114"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "80054bbc7624dc76853410b974bda7ceefb0169d7c2c7a465bc68f521803dfc6"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "280fcd1edba1b59af8a2d4b578904d25428ccff6e865c44bbfb5434d5cc02ddb"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "9312f33503b64115b45aec9d8a8e59c1591eeb1776348ebf1ab6ca5b0070885b"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "7e65aa7084bd87f1d752b3070bb8c22fb85080fef12432db11eed8ed0cb0c99c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "d0ead2f833959fa4f33f8469fad933c3040774a050f3af58462e3c3840d258ef"
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
