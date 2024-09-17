# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.6.0-255.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-255.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "a91c9e19f35c6935c6b7a3b5ce5d3770de754eb32a6bd333a33a930f88792044"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-255.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "3b932690a17510906e7e85a25ee11e473a44846c001eb633259224fc2f72b319"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-255.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "7ac64590e22236c816074bc207e87463c148d18160a15c5485aa4b44dea5b1c6"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-255.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "409df615a90486a397284526401496eb18d5bbace5468473b02cde3bfb7ed917"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-255.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "798efb7e4593c99ebdcf882d62eeaa80af6c33cbabc7a66f38f44cf7ce0326b8"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-255.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "68290b5a6fbbcc02bf18b5552e0b177077886e02a9df9334663e65ad26c6ed31"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "7d673ca3ece0ff563061d65a0e5b84ac8905d26c257fc8dc3d543c8dafa1d0fc"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c73ea25a5b01312bfad0e222dbd6f0677c46e2a4faa19b9c2b18f8506da03f8b"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "34f6eb82b226dbeaf61ea12a6d9cdd2d3374f7baadc38a6da55545ebc6ba3500"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "5ea88c21ccc5d4388a9d304a47ac4633c40b24d54501ceb1c7b166b14497387d"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "fe82992506112aaf63aebbe2716c133db30ba2c98d97926c0947a2d8d023e5e6"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "30b485142f9bde8a967114a9094d499bdbb1bd3a101adadd5268ce1ac4c617db"
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
