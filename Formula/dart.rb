# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.4.0-204.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-204.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "66447fb4ffdf899a1ec37b96a1ffeb57f16721ffaf18f4b27807ebe838202776"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-204.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "c01ceb7718a688ac2fc7b046c607faf2320eafa1ae0ea51b86027f7ec43ce454"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-204.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "4ddac5c6311d3dddc24eeeb9d3e2b5d97a699cff6cc4f281761bcd5673d8399f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-204.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "7892e47ea71b2458256365eb2add5d9c7cd9619c87246a5f477544089a088cd8"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-204.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "06f92210a66553844c2bea2187f3de2a4e64a22cabbbbdc7eaebbb3c51c12385"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-204.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "1e899ee59ed1d8657c6930fb9a67fd55b6384ab83c23461cd20fa1ee938c3267"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "e56dee147de7db5e443e1f3940ec98b0deaf3ce512dacc0baba452e47c8e30ca"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "01ec3991a91bbede2afda47d39ccee9ef6ed1fa370384b72c1e8c29d3201c4b4"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "1b1016fdeeb2037d181bedf3a5674f526f5a0ecb1bc97ed479dbfdbfc5a6d756"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "cd8b2c5a13220bc8dff2804de0c7a5329c0aa397874f020727a961c3a91db2d9"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "eca94bec45d06b16d6eb5185a9cc991e7966d1d6bdf9adf469d77dc1abe05521"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "e02e42f0701ecd290d195e3420901e4e3b91af57ba5fe7a5583b178616c2c2b8"
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
