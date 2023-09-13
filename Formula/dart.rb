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
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b3ea3cedd598cf3133e8652721a06b4d7457d2b50be423d57aeb00c3ba3d778e"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "d31c3cfeef372169c4b709cd18b1c6bc484683fde94cd9c96c54d1e53cae2316"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "be679ccef3a0b28f19e296dd5b6374ac60dd0deb06d4d663da9905190489d48b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "5c5d85df84f289a51eeed147d38e16a77dc33c445fc53ed3ef5e5700b981194a"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "395180693ccc758e4e830d3b13c4879e6e96b6869763a56e91721bf9d4228250"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "0be45ee5992be715cf57970f8b37f5be26d3be30202c420ce1606e10147223f0"
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
