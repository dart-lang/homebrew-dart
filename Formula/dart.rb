# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.3.0-16.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-16.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "49725a7bd5ef2af72e5e4a2495e904cf81c302a925200be13f2798b069f9c629"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-16.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "8c34c1760fbc75761fdd9328fe70f61320505016c02660b7c7b0782905f4ea32"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-16.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "942d507e3aca412f8b54910f9e34c4f76e3ca61c1fffa46ff30bb6b926354fdc"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-16.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "03e8fc8c3abacd13a52781d1f4f26699d33339bf07b9fc32d794e6d120758f2c"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-16.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "93352d1ed979b864fa53fd67768cd4ab8ae0dd86b05d773f7e3f9fcfc0f70a2e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-16.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "df3364f5e3a57eead9f6eb7075794604159d79ca8b15bb740169bbaab36279d5"
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
