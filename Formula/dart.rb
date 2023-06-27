# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.1.0-246.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-246.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "0c2843f1637f0a1b1b6b3aefc096c7532bde8b0404f1ed6b23d7c7af042da342"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-246.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "4510a6aba49b2fb7bef74821bd2a7fc5f88a4cc338e5a8781bce13e88debec13"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-246.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "f911b214d32f88925423149f84f18f89e3ce2b954293442008e027f51f57b882"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-246.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "174c091dcec3a9a4dc0e5eb359380ab307bf6678905e05d07c49d3a209faeda7"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-246.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "cad1e3ec8a108852d03f59c38e81a203b60b70f14ed8bfc24bb050ad98d267a9"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-246.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "16180c8a23d3b81f9205366d776ef455241092f2be3217b5e057e79373f78dae"
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
