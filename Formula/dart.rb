# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.13.0-69.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-69.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "a2847a1e0adc6f72673b5e31154479935d8a14f47bf1f8853586f16c17a7d058"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-69.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "47aae248ca652150297d454102cd2acf2f2e0ae677d3436c2c833a01312b5bd7"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-69.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "acb9aa0db551e0d69e96d032d2838d8d9f030066db4738d17700c9011715f44d"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-69.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "f6dfad75bc30ecc0ffdea7cc28831b3cc2da638ee206dc306ffa848dea0a3c75"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-69.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "0c47c54a925832e4cc326fc40ae0d6f25cc13ff1aed6ee3576fb680819837c18"
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
