# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.12.0-239.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-239.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "aeec1270e1fc79747cde800309d2fd60d8f3d50c72b63a79dad0199ffac43266"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-239.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "41ef297570c36da093828bb0fc17b5193c030d5e47a45d08490935c83efb9c82"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-239.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "7d585895554833c20d9ec63b6915fa4f0cde78c2efecb0bd94fb3b42c89d502f"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-239.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "0293b2382295d92b247dcfefa39322faa894ad033ed5e4d779269a7277f66ee3"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-239.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "0198d62683a6664cf609c4a88033df7ce0647c1ba104b5dfb7637976a3f22736"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "dfe0ac83b0cce53d9b409298151afe97f1c4574e53e4b16e04ad3b68d24fa96f"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "f0f8eefc5489c1952b952d3f70baa52ae05412c448ec1f8d9d0582dc733b8645"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.2/sdk/dartsdk-linux-x64-release.zip"
    sha256 "e646de59cf9bfdba8ecdca7b27a7d6bda3bd14b4a2256728b58172fb44bbd672"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c594d646319a755d332e8d438e1a0693214e73b2fbb798d0a72d909373ba6646"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "1a92197956e98fb98f2a10a841337ca3e21ab072401fadbe513a4009c0c81d7f"
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
