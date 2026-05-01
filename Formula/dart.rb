# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.13.0-89.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-89.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "79c0fea74fddd3489415a5c1a28b8990abbcb77ea164ade42a3a5a47af43ec3e"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-89.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "edd7a93440ff692985ee17ac92c9be203e4238b94be64f23daf6ada14b86403f"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-89.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "d4563f7f7ef14656481989914f23e7ccbb0a8c244af827d9326432b8296d7def"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-89.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "32be47bc2769314a40bb891b7b209926230ff2bc7744c4a6ae3b0de754dddeb4"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-89.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "56989b190a108d93462a3ff14f1226fbce9b18ba3b66c48f45353bfc52d5d163"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "94de6a18049c354026f5422446b311cfc96b51db6d316eeb7ca46ff14c0b8aaa"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.5/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "3fd03deb3b0c7897a9896c3f5f3dda4a9fe63c43b14364ee928ec6db348be0ac"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.5/sdk/dartsdk-linux-x64-release.zip"
    sha256 "57f3ab5ac24883060b1ff12bcdac472ed76563ec7364e88f8a6d41e4f0db075f"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "50e9aba58f8717943854778a73074e63a80c42054355d35e2732a0cc0824a2fb"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "27a3fd1eed416866171c833e98081d051ec7667d6c6f1d4a6d8f5637ac852433"
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
