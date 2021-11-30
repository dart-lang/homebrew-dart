# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.16.0-55.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-55.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "7b3155632c8b2b86ed51254a0fda9945963b2990490f0f24d0d014581375f232"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-55.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "10237982da33f66175eb473adf86c3db58b20fee280f7cddad95957a57fa6eaf"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-55.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "69bc9f6484b4b1f8242f685454845c5dd731a27ac0503b72afe7bdc50a832aee"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-55.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "cce1e6dd32f5419c8db02250b248476f697876aca8026918f6b685715ef0f6ee"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-55.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "a913c231997679682ca7f87f49b38f170d765a1aebae92ff142a311eaca3dfad"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-55.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "ad4f4a0a23d120f23d6a5ea05aac356fd4e560872b0495ba7a8ac66da8207517"
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
