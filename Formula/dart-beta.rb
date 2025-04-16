# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.8.0-278.2.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b80fce276797f27ccc6583fee6e7fd229f4bb1b496a324de85a503bb5a438b45"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "85f6c664bb524da3ed57536e0f7e71f6661377300d728cd0171cac3a1d80a790"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "6f53574f123efcf43659030f18038f460fa976ed1b12e66bffa991f7d5ad87c3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "6054e762f43618c653a2a607f5e4d237393a40db1b14ed83add8f6539a917741"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "9576dcf1595514b434b65620d7dae86df1813e2be084c176233031e0848cdc69"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "6456bfdd97f3c0ea76890aa0847fb1ea90c5a95551481db7f1bc98fcefde9368"
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
