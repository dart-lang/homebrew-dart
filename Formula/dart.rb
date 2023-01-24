# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-151.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-151.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "2fed52565be3f8d1a135da5d2be2690ad5f01a66e2a1b015a3f5e3431f632749"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-151.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "3c92284ed3426280b1ee5596561bba3882e1ca87e85ad553b6e1ffdd259ec7c2"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-151.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "e04321b5aa415b36a346d7948c2495f8072288c32f021ded7f4f55d22a509c21"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-151.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "d57a2d31aba6407e55e79fcff49445701d030a476c6555ba24ceefc313004924"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-151.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "f01c5c9e3975de6f1ababdc2f63bb057ec0899e56785e83ec44c458c5e7d9253"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-151.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "6662694235246cdedbc6f42a48534292ae90b009559b42c3c9286a606957546f"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "2163b8a6bd5be8d54036335204a357f9568068b6276dccf7b7c22a732bc973c1"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "69d0611f528d77aa2a090d34021511f8bf4c441a96e0fcecfc046a2bce5c0ac5"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "aa2abe166d898b1bc1f67f87836d52087ec29c19e6f8940b4c370f969899d44a"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "14fc9684d784d5f73c72bbb9e9603acf36caf082f224023dcda312d450f7fa51"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "71f312f7448d42386b23361b82380cba2b0f0d60406190d25714b9d21e6f7208"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "c1f7bf9e077927beb6dff5d4d124197341ee89dcfedc1dd153de09aaa4818368"
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
