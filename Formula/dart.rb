# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.8.0-43.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-43.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "994bd30db68cfe28f5e85b202892942c1ab66dd24d3bb601556f2174994712fe"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-43.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "857bb956f67ac298ac90b3749ff6abc94d03ba00c910aa998a3ef720055c0b9a"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-43.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "6ceca18f870223eed02a7d5d77382be0b308fadd4740a564de715bbf5cca02e4"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-43.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a97ac4b5a57a3359872228c162a5459c52bc6108ae283769ecaed7e04109d46f"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-43.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "9dbc191355b176e2ddd52a6002c469d48e6b3fdb78f75584e39e557e3efce35e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-43.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "bf9112b1ba098f6d968047c3b00fdcb37724d83eb0ef201d50bbd440546ad463"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "8ac74b6f5e0524d767decbb7a04e93482be4a09d012cd577f29113893c19bed8"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "453bbfa3d73f28e090b644268e2c809b899d11a3a6507874715e1a4042166295"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "5a2953ec76c8139cd73d0c0b482de26d0b86a5a7e37579167bbd33493063408d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "eeb3cd33ba4d8be2cb5e43c3283a5034f009103cd641eef6f0e3cad701477c43"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f475db0944922d9925b4a4266c31f8fafd39b01a3cc130422e785c8276eb13e5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "fb06585de5d9b2aacbf8970be69c91292b29b4dab315b84789f0fe528675ae16"
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
