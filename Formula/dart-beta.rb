# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.9.0-333.4.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-333.4.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "cb5731ca61e713617006c41c56e66980882b23f4e11300ec78727e7568fc1eec"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-333.4.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "4b42821bdc6724c2e5ba5ef14756d99194237c792ce983d23b592806b3437033"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-333.4.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "9a6b1cf6abb73c51ae1129662724db54939ec6e125b51079fd6fc7855fee3bf8"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-333.4.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "442c1a94685c753a83e4192900ef4456a44f61c3d8f18c43488b00824d2a9906"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-333.4.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "8b8fc4b8857a2046d33efe53576edfdbc006e2d5cf9a376a4328d4947cc5f94e"
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
