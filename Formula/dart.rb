# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.1.0-213.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-213.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "250d664e364bc3523741522e09c37ebfeff5a3a5851ebdfb5fe9dbd98dce1cf0"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-213.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "1d6ded06213ba8b1ad305dac616f9987e8ee9a23876e5055e7b1690b9287505d"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-213.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "1732e59d87562f32b8a6a88792ad5810585326711cf85555f557d10eb08d4942"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-213.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "30a1eb0bb5b215ede91818f6b3f049752d6d8cee65ff80cb7774aca23de6abdb"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-213.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "3d669dcb86d703638808511c3b8d871deb7817021f2d6907cd124546e2f88b21"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-213.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "6337502a41895fb4fb0395c6d14a8a18c4682015cdd4a435b89da9a1877b42b1"
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
