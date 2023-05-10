# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.1.0-63.1.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-63.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "d27035d86e94c00c4d8b7ad9d1496b93736cbcdf0ddae816bac4e497cd01f02c"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-63.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "19861fa9d167e0cd46dc0528dc2c42384e6b2a9dc17e73c3b94ca9cb2eef438e"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-63.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "1edcf9e1c5be94633fa025614866d49c437322ab3cc759822645287ddb9bfd62"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-63.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "89456ace89885b5ffafc75130f425bc61d455a528b8476fac4c8b73c526381ae"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-63.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "63442bd94a4bcb043fccf9f3f22a5ca846fbb3a3933eea84dcfe8502f8f767de"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-63.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "82c73e025efa6c4020985f85fe2b46264000295a402e1be9e787f54c17eb2590"
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
