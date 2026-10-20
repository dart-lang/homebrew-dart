# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.14.0-315.2.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-315.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "55f07a8a5715d1ce446afc388b4823efad60f174ed34cd33a832d2276b3ddf6e"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-315.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "d9b9cadc25aa7819e88133db5fb37f8e0677af34a5168ad3ac7e38f15ab983cf"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-315.2.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "6168ede8e1b2520ca3ae1e0c94c36bc1a07ac68f44d54adc245ef0dedc443ebe"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-315.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "aa2d893e5a231520764d3c80eba3ccf3fe45045d740a6c2f8853d98cd0f882cf"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-315.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "39bc4a9f219366a434e8439e182f6c29e3e2589323a6693c14db03cc6f90a89a"
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
