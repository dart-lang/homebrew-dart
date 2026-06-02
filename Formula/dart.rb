# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.13.0-155.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-155.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "799c5bc643353aa6a2fa3d99ba5c604a0e5a7f16bb4ef00d7b8ed586df368fed"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-155.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "b0da5a5d732ca7e8f577d0a44a58f8db65bc94bce4d7bec4079ebe629af7161f"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-155.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "c2805d9be0ba2eee1f0dcd67489b2344c7b53f64a59e5d9a8316e89b3f0cdde2"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-155.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "6918fce4ca21844909575f0b226a9c3ebf2e21bdf95df25d4997e726b8d81009"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-155.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "7754c3a970fd22069e2d7c875595e9278ac05aed94ec800694097d7a11602c84"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c56b322cdbc15e0d7c373970c2e2be53bfb438458bd67c1828703e744acb7916"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "eaff3823d5a0c5cdcb65b38adf204e5f35290fcd560d48cb47c2fac7e1547b97"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.1/sdk/dartsdk-linux-x64-release.zip"
    sha256 "6a2bbf64a133c9c86a62a532dbd3e0b4db4ac365abd456e9f9d1c5df61fcdbf8"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b44087930108f6d7f56bf580a02d5d2a97ff94519c5a288339982202e1b4c481"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "51dfead169350b452a24230b9bcbbf11ac15cda3f993dab32c63a51b3689bbb5"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"].select { |f| File.executable?(f) }
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
