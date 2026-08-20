# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.14.0-143.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-143.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "a34bc84987079cd367a10ce180e044047d116cf1cf7c2d91707356d27f825aad"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-143.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "bd09f4d6d03fc9bdef92499c7bd50c79e1632a394135918d4e2cea62dc8b1eb5"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-143.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "22ca6d2679ee2591e6a534e364ce7c3df01e08dd5f494cb0d4f8aee582f5103f"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-143.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "1d0ac6b77749bf7107a8b4ebbf8d587328a9d37fde7090eae717c8bb8cf255d8"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-143.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "1f8904f2aa19e678f924a8c96e7d905988bc6feb22133d68cd86d2f21e012d33"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "6d25d5e1cb7dd1d8b50014d01d76aad72c450872799c0d2e25374f630434c5da"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "367984941d8d14c653789f6f787312e715e5c546f6e9f5d30d86615c692907a9"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.1/sdk/dartsdk-linux-x64-release.zip"
    sha256 "9251c4606ebb31480c45f430be69fce2697e3b888a0a828b9e16e7d23403d72a"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "5141d5ac62dabfcf0d3dd8fbf5c4d143d0092ef42fad0f25f6cf6587e5cfc3bf"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "b17aec791a0930fbe7f3d9bbf870748107ffda99a946f68be940577c116974bf"
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
