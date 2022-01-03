# typed: false
# frozen_string_literal: true

class DartDev < Formula
  desc "Dev SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", because: "dart ships the same binaries"
  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"

  version "2.9.0-19.0.dev"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-19.0.dev/sdk/dartsdk-macos-x64-release.zip"
    sha256 "1dc85c5a3a951d911f37213ca770b81db389e040fd596b6d07961069cc5b5d7f"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-19.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "b50a54667fe127cc1532405f2ab08d4d39b791d6730a049af4812322e944f830"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-19.0.dev/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "85a8c3ae785174cea2a49e68789cbed17ea4eb8fb11c70a40a5671008e5c8907"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-19.0.dev/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "46cc689582b26a5579630e855a1c2ab147d067d3f7e5d289393a0e54782221e1"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-19.0.dev/sdk/dartsdk-linux-arm-release.zip"
      sha256 "9ce5cf7c399a9b560731af847f2f89788208c9ca3546bb17755e483b62a3113b"
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
