# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.15.0-268.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-268.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "86b7ed24b312d20611e2395608b295cad348d79467e3f3d5e3d4e09f99d9aa3c"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-268.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "c816ad9b62ce8884947710305dc268e5942415fd03b5e8ffbfc2916c6e8bbfac"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-268.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "a23e9b20b51e39bee726f518336139a60dc7855619e80f7189a1ba057d62d5e7"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-268.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "4c0ba6c7e8e5a05f8d1c0e51a1c3d30941e6cd84c0fa3e856060a1b6bf8bc6bc"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-268.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "4dea4664d9b5279751f9eaaf57124fdbf8259fcd9981fa5b3d4483c3c0c23e7d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-268.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "d8b37935a007d9bc3d5adb5641d6277b676e47edca07ff49cfbf8cffa2e0528e"
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
