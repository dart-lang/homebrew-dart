# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.4.0-247.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-247.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "62f15762641a5aac4f61d6719a159d62188646c1e43c8bd93fd33eafe63229f6"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-247.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "95eec1e3dfa7c891d928c0ae3be9550675eefa95b240ea5dd414f9b4c2a90369"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-247.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "3cff0b896fb2f665c8ab2cbf746882fcf42d2def7c3c64db7e2208ee092932da"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-247.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "b4b23033833038bff40f31b1e5a1dbfeb8918d24694741418236496af5a3864d"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-247.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "98c0c8bd016ba6e1156d4630409f47ef42e16226efe331751e706711496208fc"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-247.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "e20bf084678b51e65d22fee57053e8649e95f27565551f1ddb15cf661c7bf170"
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
