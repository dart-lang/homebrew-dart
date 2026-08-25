# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.14.0-154.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-154.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "9b4159b785ffc0bb12f211a60a1ff04be534a89f11ebbcab302eee8e59265a34"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-154.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "354248e6791a0a8ca4fbe0a0575f3771cd1be7fa20a29fa935b5d191fb4a6ce2"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-154.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "e69889570ab189e61a6438872fb03fd060022e552c5f40f51ce4abe4fc3a5d8a"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-154.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "2a7ac1cc68123f11a8fc737a9a28836ea5dc780f254d207dedc934cc57bec26b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-154.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "f15a532bf7264ea88a256e18bccd98cac8d2b69960538f77db10aa87ac5b4539"
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
