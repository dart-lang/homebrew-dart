# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.7.0-323.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-323.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "2c7586a0c409f44a531067b61a7aec4b7e72589c8dfee7160c068d025bd4c53e"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-323.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "1c356b07b55089dea41030a130b0ee24ca21919544e146d9cd509b135baf29fe"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-323.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "ae07af8e2e9e2f5c0770230c870dc75473386d8f01609862cb1b19168a725f74"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-323.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "04476b4dc21486816b6cfe16e5826648a6f78554c49afbe67be97e58cbb252b8"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-323.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "7727f3ee72ae675291476c09b1416a6e4b466be8c96d997c49bcc899a4497c18"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-323.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "3a865f73b4be760cf34cccab3b5c5487cff4569253053eba0f098e58538477bd"
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
