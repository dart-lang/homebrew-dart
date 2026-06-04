# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.13.0-167.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-167.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "10b2a31f681d85e18a6108fa470452e0df47f29551c659e54e82d9a480c02a3b"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-167.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "01491e3ddfd34530d1c077dffda6837b687412ded3d20a5142616d3a96cfbf30"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-167.1.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "6d68094f7f706d62c632a69e86b979fb11c8aee4075fca84ec200d62a78c233e"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-167.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "bbd0ef24966e574560b6aecca1dde05b4859d5749422d0502b6d1692d7d70e53"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-167.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2d3429973e8250f42bcf43b9700274703f7955989d07b227932a02c1cd2cfbd8"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"].select { |f| File.executable?(f) }
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
