# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.2.0-150.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-150.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "fbd8e735f7b23853f64caf26987439ed56202d8c4df8b46f2ed59cc4f17798c9"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-150.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "ee45f1292181d22160646a2e7d7055cb47d7a63a021d5817301a9b10e801133f"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-150.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "4b411a63f3b20dcb2fa8ad81d7ec0caf3fa19deb13b7ae5fbd66acce99cb992b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-150.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "3092b0c8a4d7d49a6545ffaca987f6fb0db5eb896a2f08ee009c147dee26b6ea"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-150.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "df63b26de4699be1738ddec36fcb98b98ac880e2223d1137caf40a529e8c0799"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-150.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "4a232734848d59cee2ba592079602e3e9922c798a875d3890caf1dae8cd5a4d4"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c34e9b2c45375f86ea4fa948215079f3ba4394ce8904f4cf33664d82dd2cbbea"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "a0435e9084b714efb527a079c993cdcbea4aa3db81d6d16fe68235bf3e44f43d"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "1353d67c3c5bdf550f170ac5203b0722be91ff32fe756c36a21c0c6c208c25a5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "c189035346e7cc7fec5f321ca08d779546a6f1904be66ee4018effc649f22790"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0c5c4f2d25603bbbbc2e389c0460d84f145c44093f83b11606e9990cad7fc3bc"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "e279d5e475a257a84fa86718a559fd5760f80cfb92e3cf4f7143ed856bc3caa2"
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
