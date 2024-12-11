# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.7.0-209.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-209.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "bd73444e9b74b9ea02406fef569e36bd189691b077335cbd4dfcc43fab4e2405"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-209.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "6b7b192988803409fb7bbccdd9a6ab3e785beeb9fd86ead1c7b67065836acb18"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-209.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3b8eee768198b0dec627afbfea7db0c0004d2c55d1ca999c7061590ebaade7cf"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-209.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "20fec43830c615bda176584a11a2096f61b0bbd34093cb093e00ae0ec859cc1e"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-209.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "424e554d41159701cf7a2b537a07addc6ac641339f09e8b186ea07312d0dc212"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-209.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "69a5c7a68599f109364cd26da77500d5b1e09a4dcba455c562b7b7e2a502e1e9"
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
