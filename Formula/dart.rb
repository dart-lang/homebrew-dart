# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.1.0-189.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-189.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "198925d160c66c7935664746ab982b55844597d4c5d43c4395707fc8024b51b7"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-189.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "a1d306cc8fa2f306cd36742443f199a78bb15627596445c987ea4a0ba661e0ab"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-189.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "b7cbc357a975122ee317e565b953304f6c134084e04ee42031bbb4fb05b8a1e9"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-189.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "2b12d8b69f9131070bf5c48a4455929681a8f0a3b02a3b74b11bf9257c6653f6"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-189.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "bc3312a0b01501116c20d97af6e768791c9d4e62f9802aa43fd9533e978ce451"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-189.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "3c2ecf7f91b17b5ae92459af99232cfba153c13fa4aead3f6d2fc7bd8fba6022"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "1c878a78850610235ae0aec89179f994cb5c5b3346b93089562417c7b9232a31"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.5/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "6432891a8569b3a7968f86f58f469f23858d22b2a2a6c3bb3ad87a62dff36698"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.5/sdk/dartsdk-linux-x64-release.zip"
      sha256 "05fba372d64932dffce90bbd45116b76806bf9adc6203967b56faf5c64b2b66c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.5/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "8a5c159c7ed7c6896bef1e7db6315f0c923d81b78f7433bf0ebf1b6ef4b1b90d"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "667b79593444cbe222a33c137ca943dced7a21ff2d61b8862f3b49e648c20533"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ed151fd396522c09c41820e627eea8a72da973f7e0aeef8e8099c914b7fde2c1"
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
