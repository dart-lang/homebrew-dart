# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.11.0-90.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-90.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "c81c1665e1490e3a0b336fb8a1bbe3d2b02e25a99752a85b76bd123f7123a610"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-90.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "b686dd1f6659c6c94403a2b08d21dc29fc146612ffd511721f42c06a0290e740"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-90.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0c37dd2c5937ce27954864b9fe021d7b67ccc5e94c84b46b2058ae2afb910377"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-90.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e2a6beabd74e81025cce63151f6f12d1aa881ce5c688ba3a4db27c4380139881"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-90.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "d89e8b0b64a15000007fb78ddd37e6935dfdd3b92daf1b2bb1980f9ab9168a43"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f27906d6150f9f4077af9c7106718c8e039aeba031dcb42056a331fb74e3dd2f"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "da0aa7f35e94b2ff25ebd42b7c9b21d430aee658e26da05f6509f84e15019480"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.4/sdk/dartsdk-linux-x64-release.zip"
    sha256 "61b4b9488e1b4255b94be17ad48ae2ddb23c6fbe67824cf8103d0b28fa8ab816"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "21790958b6c65cb57a1a3c3fb508f44ddcfb77b822a090039ee47e583fcde0e8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "8490f1d4a137e6b9edc628f7fe56bfa2d93ea22d07981b37bcb08c4248f03be8"
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
