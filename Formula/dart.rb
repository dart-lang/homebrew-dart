# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.5.0-58.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-58.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "37a16c1fd9ffda0867103cc7f75f4823834da8472cf3370fcc579f44235e4404"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-58.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "430c5d7e4d2c4fe6b0ef0ae3ce192bb8c509bd5f06b00ab67c4a465d4e0c9c60"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-58.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "9953043dec1776d19e327521228362c07d274cefe1700a41dcae73a63f55420f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-58.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "40a5933a306c31dac050279dc41dcfd0d5a0ef5f924e16ca3be162ef8d7b5378"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-58.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "a6f3bc56356be47480a6ce1c17bb65ec5158410bb180f905d2d9ac4bc025e856"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-58.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "e4f0a03852f90d1a92f6c741d15f361a788a6fae378cdc9ec093419a42d7fb37"
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
