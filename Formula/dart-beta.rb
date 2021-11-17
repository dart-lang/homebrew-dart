# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.15.0-268.18.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-268.18.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "9431110ce02e6a9d45135098642590d04c423a7e6d16ca319945ffe7bd3ad530"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-268.18.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "8e4dab94e8793e8d84d1b6fe9dac2807ee5ba80c3c34a25fc087cf0d981fcc85"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-268.18.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "c93c72123f27836e9a6131a5e24b46fede7570f0388b5c9afef8f71232fdaf84"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-268.18.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "a3e1745c683c4280b1561221e8cfa78ffd3b38cf8ed2133f2333fb20b8823df4"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-268.18.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "aec5056aa84bf8813d75f392e1659646a868bbb944ff1d3fc5d95282b987f771"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-268.18.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "6525d9b92bed7dde3576d59333c8367b92f1b4a6e6e005918717728c9451fe89"
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
