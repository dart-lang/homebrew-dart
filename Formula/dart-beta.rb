# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.4.0-282.2.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b6411e31a1c229d85925953c81f9ff00309ab0dc257946d8778431208a9eb248"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "d7ff82f30b919379411abf1df8ccbb64b50b6cca0022b0000b143a2f87b2e66d"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "7c4652d0d1fe5f375d6d810e98dccaeda02d8dd9251babca4c53b7ec4c20a697"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "1ebb354bdb662f02f0c56f47c73550d0d8eaefcf1bd5e8c816fc286d4c258c03"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e6bf4b25beb84aac39b6a472888230133c0324dd0dc4cf261176f8995fde6e0e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "21d47dbdd97708adca357e780741c216bfeb7a4fcbe158e6cead99ba3c75f002"
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
