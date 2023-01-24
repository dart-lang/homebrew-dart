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
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.7/sdk/dartsdk-macos-x64-release.zip"
    sha256 "71675de774e19ccc872234ffcbd96401af49b88330001aeb47cff648eee790ca"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.7/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "2742114776a5b476f64cb96596eaeb2d346f65686b7f358b06de83f0e3eb2a48"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.7/sdk/dartsdk-linux-x64-release.zip"
      sha256 "337de0ad3ee66dca7ffa81fc3cd9ecd53d4593384da9d1dfcf4b68f69559fa2b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.7/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "3a02c848c1ea1ae2f7b0cae28ed5ec6a0160a795b7440e2e217aafa3eabeb0d3"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.7/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "684092802f280ca7a64b111da647bbd380d2ce5adf8a23bcd70cc902a3c4a495"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.7/sdk/dartsdk-linux-arm-release.zip"
      sha256 "daa5139774ba50f100115c79dc193c0bb0a48737c79eb915ee8f25c4ec74ace1"
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
