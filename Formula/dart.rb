# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.4.0-194.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-194.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "73b8d521cd317c619fd793bdee1f7bc814c8f11d1a63720c87f4a46bd3e4e824"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-194.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "1e937b836edbfcb320485a0d1d76f562ab10c2344b45c35c03181d7f9c8a3a87"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-194.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "39f2e0df5bbdb47489b74db12eca984b923cb473a676f21b3a225bb77f986f7b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-194.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "1f5bd7a1f463805c12524cdff559ce6f113802135f9df21691ae3c604c6fa206"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-194.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "8fbff2f454a6fd259e8e823be63db294be6c4c300067ebda9c5447cb43970df3"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-194.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "261a1e308e8823ed14548c101370ae22a557ce19f35ba56200f0b9325a0989ac"
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
