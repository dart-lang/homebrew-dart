# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.4.0-242.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-242.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "df41d170f2df52d8c51d483dcdb6ea40c5476aadf86f18485e7555e9579bd177"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-242.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "3ebc5aa0328488de0083e54a47faebd5b86fd2a4f91ede198d056d966ed82c30"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-242.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "7280ea97cfbeb767f92c941607062eaa609dc09d732fe4a39c9a74cb2d41648d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-242.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "4d789dbb002e4cafd76ccedead3b3d93da67eef05b152b49a41f919e6e2bc31b"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-242.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "4fb15c96f7986e72ae0ca37b3896d24a05cbcfdd071513b71ac37a94e4a034be"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-242.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "c92ef0badade155afe71e0be9763508575aaaffda2e84560a905c1e3946471a5"
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
