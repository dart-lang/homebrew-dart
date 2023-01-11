# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.19.0-444.4.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.4.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "ac84a940f6b2458fe4812c454827a81767e30325b90e3a3f6051beb0c372fcfb"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.4.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "11919e9fa3c669aea1bb64a308cecfb81a86a4f546a37ed9251e314318d1bd9b"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.4.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "a7154a06224168546f75b7f6294e9630f18da7ab33d28912a1bc5fab076f9da4"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.4.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "b6a371d9d9564787ce757784a1d6c5018baed8cc5431752665078928c6dd5323"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.4.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "edc4bf48b3bc3999caf8c3093dffffb960369699bc5ab912ebfd153cf02cbd35"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.4.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "d027251be6f47dbedee07420c054510a8cd9019bbecdb92dcdf9d799f1568a43"
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
