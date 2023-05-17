# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.1.0-111.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-111.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "d0eba34f7df63f059a1089d896eaeac21745ecc300133347d6d66acfe649c46f"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-111.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "bcccd69f13baa2879a29c7cc7f179a044241a1bb3b198fce1fb690fbd23b0b63"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-111.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "b60573251ee22613164df137343156f9dc397ad86c90c24bc189a9727caa63ef"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-111.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a3abc230b620219a856f9b99c713f0bd3a1ac9ba6612984c4b098089ceacd4f7"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-111.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "534f3ddaf3b4e7dfbd541bee4ce3de813371e01726869f490e21f0f56ceddb52"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-111.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "6c260967184a514632b32f6608eec41c4db7ba0f7df2d117e70823f457b85403"
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
