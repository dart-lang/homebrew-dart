# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.1.0-250.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-250.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "a0b0194f3d7d4ab7f0fea6f9c703d5ac2187d0607afe0b710634e3877cd158c7"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-250.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "09bb4ed4b831b424610e93b848f998330c533dbea8f07ec3513bdae9e77c08d7"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-250.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "7e69054c81b2f8eec954fb11ae6e34d51e3dad10b672d8d5e66f57fb78765ab7"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-250.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "b441d8fa2d8930980472e1429479cc0823b69bf3094ce6fbf322b0cb4623a956"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-250.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "c66e353847b4c96bc5545f0a8f301ea48c37872390ce8af62f00ac29c36074d8"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-250.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "970c43b727ca7af169ad7fe92cb92cfb67377c95276f23a8ca9b2f5dcf7f4846"
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
