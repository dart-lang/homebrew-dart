# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.8.0-278.3.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.3.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "21a32068b3c44a9456c5981b4e688263a5a20f5b379a72e945605712f912f145"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.3.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "8eb67f71f8ca37fe417e55e98376776bb2cf87d428275296727b68ba0943a53b"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.3.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "aa51a0602ffce9862176baac512ba18dccb913015f3b6caab2ba133d67d3c486"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.3.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "bbb3b3fdde4d5d718598193c6dc83ea8671a8e44b2001199f27ffbb88c1ff38e"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.3.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "ad12d89701e0867e530b3c2d5b2936fef26aee75238b2717b989ac9c4b6767ea"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.3.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "9fb91b6d688e58d8020c053037f369e0c61a28534965b6533e3e4b4bdbb22307"
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
