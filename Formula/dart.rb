# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.16.0-80.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-80.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "472f02f6a26abf869490dc6447dfabd4786a55d67d6ad9bcd192397ca370f2b4"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-80.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "170cbc7b303433c82b90e63ae68f95d25142d381204c395994a9ea4faeabe1ac"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-80.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "e62bad19024540a641f463523c952e1ee95883c1a5cd861486ccc72f4614cfab"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-80.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "66d52ff24c149dc3325cb7dddca39d601c145bdf055eb3dd36269e8c4c9a4bdc"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-80.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "b9b309a529c1fbee4ea3b0a2b5da45c93dad178332d0370f8d259c1bae99ee1b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-80.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "87b4f0e4eeff27a4544757d373bc55ca23e584369ac9b3576327884146a00bed"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c900f6ccb62e2f7526f457d00be8fc296e7c2ce9c7653cf007b5a4db7fe9a9ae"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "3abaf0c2d57e05c27c873aaa47b7d88e59c39d5fc78ae9894dfb880fa18945ea"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "49b6a98008ef546cb9c221461529d6c02cf2474bff098e0dc7e4ff1ef0f8a289"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "f6b73006af2e3bd1394877f2e539ef88ae6a93968a56d4124e3b0b5d68b4de36"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0477fae6fcff58fec18d912537f13d647fa0e137fce23401eea73102dce62351"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "796b64022615ea75f05f20a3d5e7018e52a1d26c06acb1d2b0b2faa5df491a64"
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
