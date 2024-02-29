# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.4.0-185.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-185.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "6f8c55abc37bd72adcde30674f0fb18b8a6b17cbac300fd2e77beb1201e8a892"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-185.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "e2cce01ea82fbb886ed4b529fc317eeaa88128aa8b0cd55a68e044d764680b15"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-185.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "49c13a98de3dfb518491e74e9fed1c1b751c23fd51ade3d1094b5498e812cb32"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-185.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a0e5af6ada7e3ca5b87c2c23380d99bb82305c0013b70c3cf463cf4934e5de7b"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-185.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "631859b111e8ed9081297c34366b4e6f0baa57b1fd1b1a68b2b8a083c438b97b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-185.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "a3acddd67a14e2b63850c0dd6e4ddf633049bd55628894795727fac6d091c441"
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
