# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.14.0-377.1.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-377.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "e555d5a3fe71e06dc61b78b7ca2564a65cdd1aa6201517a2de3ea27bdf7c8ca9"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-377.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "fa35bbb4b9ac211aef35ce85a81aa1769bdb430fe3ff730bb356af4f0d10e1a0"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-377.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "1caa86d8acabf6668817808a2d8ecb2722ef69f1750ea4d7f82b49368978e688"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-377.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "7f8a365a15ca50f3f5d069bef2793a6f4065ddf10290a744c1d9db7750ebb1fc"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-377.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "efe2ebad165a60a7b534ca6c2d1508b59e593ccbebb7a2a46fd2b1207009ba0d"
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
