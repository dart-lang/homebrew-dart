# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.16.0-80.1.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-80.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "7dfe110898df07cba06725f309dde92b2d1f4d9333c3b4ac0d718d7a46dbeceb"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-80.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "139ff7ab08fc870b69145866a781090461e1f031a099b669640349006f20d39b"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-80.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "b758aefce016c0dfdc8b4e2941c88e0a5c0d29339c4432abd58fab4ef076d2dc"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-80.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "3da8edda6ba13555872de89397314d8798bac3ed0e89db45c977ca3ec07d106d"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-80.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "1427731141075364bc2f6b2c89c3db28e781048b05149ab8d336ab213382aea6"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-80.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "a6db5eae93c894effda6aeac737a304a31f56c48dcea21ab80fb7b16febbaa53"
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
