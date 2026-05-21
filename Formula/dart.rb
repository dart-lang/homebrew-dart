# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.13.0-119.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-119.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "4c67f164240524b536fd64ab131a2b65c96b77cb3e8dfc8a2b298ce6fa8f6aaf"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-119.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "1c73ef9d1d19ef810556665270ec1ee72a69a6e47f67c8f3d1004500450e5522"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-119.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "9a67c96e2eabc240ae236501f15cb603abed880565e693b41fca14c1178008e0"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-119.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "018bfeb34f7e4a4bc24654d7b8210d4bf0eba0333b666ef8bba61e4f9af75e2e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-119.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "6886f58d3d41fd5b1ac3e371ca5c99ba8cefda76add57b07ccf6e849ee0f7143"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "50a11ac4c89a2c5de2f313afff63f5fab2b3bbca551119c140feab467253beea"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "47e69e2048670a9fb77cf0362f7cf7057c9fddfca3ce22ad597e254cfd6b55a9"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.0/sdk/dartsdk-linux-x64-release.zip"
    sha256 "45773140810cfd433402a58bb2ead4f43cc55805c34d2de0641c51012591d65c"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "17e901b9029c1be256c64d937595725a242b2052dab810d7d10f715bed7b6d90"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "c8919bba2fa9f72801d709485fcff27f73f0cc58d3f3f5dd056a44a317848ffc"
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
