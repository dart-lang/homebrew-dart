# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.1.0-227.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-227.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "16956c12c54d512a5b65ad3e99a50b33ba93a9a4fdda062d2e04dce9257a7381"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-227.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "a9c2aa1f01377b703bb2327d0700e0522bb50d61c6b8d338ded70047fe05b37d"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-227.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "6bc2bea37b6d874b110f7a65dd92a64abca7c85bd885045b3d166f9a2efc48aa"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-227.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "71b97e3ba776009f02a312551249d3db4e737fa4866dc005460c3f231a23b2c5"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-227.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "faba944bda6d7aafcdcda62ab2530cc179abf1ae3f3cf9585422f39aca1e4b00"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-227.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "3d534c5f19b1d1bc80a5b8c67f89907ad4f130e446f24f95df7f8e9e178587bd"
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
