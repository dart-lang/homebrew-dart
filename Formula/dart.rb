# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.1.0-126.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-126.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "89be375ed8e164c3482b18a438e4ec3ef0d2478cea90fe855555511b109a5301"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-126.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "8a7767f3dd77a8b090752c2745ee397c646aae59cff08ef00c0bdfea01cbbe87"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-126.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "20cd173d78b9fb7e0b68d348e98580daa9055d605196b081ecaa4a95aa2150bc"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-126.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "9c8875c0b6e45978831acf3b0234dd3f386b0104630bdc880d3aed1cc881ba54"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-126.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "aa3a99c4600b7ed6344bad1a99703ebb6106c5e685967cada4597a89cfcf55d7"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-126.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "e02d9f19ee0c25d808616b73b1f997491284267f8135ad48c39b949faddee9de"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "9153ca373cb24714fc21fff45f8b339b52a2ee381b5b40e3f659c4cd4d7a9434"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "db73d6173efeec4c9d8c13fd905c82c379534eb128b3bc264a2d3878766743f9"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "caab438213bffba5ab704d88155710327f0fc4326594224714271bf823dfdc70"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "4506a5abfbbe92641b436a0a83be1b5b4ec84860f6c06dac80adb1b00f00046b"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "d05d9052fe8eba57d4838cea5a29577a34988d882ea9610096f137f256409d03"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "3a36b77fc9eac1b95ca005d262f81af56c359065b18f25d4a4744249772481c4"
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
