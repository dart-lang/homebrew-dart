# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.5.0-72.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-72.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "c3d5a70b18198f8d0d31a3f0717d61ee8997e031e99e71d24840af2c42b54517"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-72.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "c9a8afdfff096025cdfbdb43960cb81c31f96504562051d531fbf4d48a3246e9"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-72.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "b543cea161b6c06f47938b2b98ee4fc50c6e324716307f80674ebb9a76949dfd"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-72.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "e5e2e70cc55ee7b3673d576fc18671a52b30448406389eba960f70a10891de86"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-72.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "bcfbbeb9cceb44f7dc5f6ab24e47b8d71229a20e0257bfd982d7c1a4a2192e6f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-72.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "559b95ca014d1c7225ea944fe9896f1fb6a77df01578e86a2785ebfc6b62788d"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "62285d9156bf6fb4439420bc327ab772df3a248b5d2df978284f510edb5d2c4a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "01c594a2a7dc1ad98d210a9751aaf0972c35b13992f0b1043e8bf93361d60b51"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "6773922a60ce6f3b259dc4877c15f1cd96f325ca48015120014f64171708a7b2"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "5207b171a9d6d88bd711e6022a101d61323dba4971a1653f568dd34d052ab248"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c3473f681de8717134212c4cabd98ef25ec45c0adddd34e3b0d99431a606bdc9"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "84bd6dc6036993b8d2b41a2012d914a28d9f2e3800fd63ae02d21fb56c467c6f"
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
