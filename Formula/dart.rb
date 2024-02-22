# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.4.0-160.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-160.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "3434cd2682a5df09451aec4245edff3baa7bf268dbd77918c34272bfdbc64cf7"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-160.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "549cac4c05edafd56fb80124cf85513213c43e082aca6c62603ebb2df790e720"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-160.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "d4cbb62c3e81caf2141139e382b6031f99a2cdd437f095575e3018ecfbfbe766"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-160.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "8dbbafd798669df690886432250ef60749b9473b9f21cbe56d5e7f7a7ab05cff"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-160.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "6f23ed672615032653ac0fb46d934d33207d55e33edad73614e5e6eb039b4d44"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-160.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "1e82e657cd71e5523e8909f4ebade95a1b47f2381b1606af60fbaca81e7a92f1"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "304ecad745b2e558be5951e6dd54b42a8ab84a8f3b6c7667258404318edd9db3"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "b254b3f2987bdf7ea2b982855642cbea9b96e8973307cabf369ef312d0b38ab2"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3ebf6ba4065ec941bb3b2e82118ae06fce34125ce6f8289e633c4b67a56cbcad"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "423b1725de2c4ec779b16da7dca7f338c4c4557803a74ae70a8382551abe3e65"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "19684c1615b2070a6933972809ed61f3f236fc42829c77fa19737dd2e8b7b202"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "65e821835cf1eed37cbe53d7e18a9e81e3fcb13ceaabaf7a6fe09fff9dae3160"
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
