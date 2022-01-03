# typed: false
# frozen_string_literal: true

class DartDev < Formula
  desc "Dev SDK"
  homepage "https://dart.dev"
  version "2.16.0-124.0.dev"

  conflicts_with "dart", because: "dart ships the same binaries"
  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"

  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-124.0.dev/sdk/dartsdk-macos-x64-release.zip"
    sha256 "2d68a8d8059cd52f38085727c4ae1f32c897b67ee7f992a374d2fe735fc7f3e0"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-124.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "e9a72d5a98924846bc79f6a0e21ca64486fe679cc9f397e138c731e42244a6ee"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-124.0.dev/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "310c4006aa104d2e0d140901af0b9637644ece7afd32e4426d592006c2e1d47b"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-124.0.dev/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "549465881d427e9330ed0f23fed8564e05fc67eb98ec7799c31c569b7797a3d1"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-124.0.dev/sdk/dartsdk-linux-arm-release.zip"
      sha256 "98ec18599ddf23dc88abb867198b313a6821f62b82163f4a8bcf32d9b99c1c40"
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
