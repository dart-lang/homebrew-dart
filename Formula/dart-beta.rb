# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.19.0-444.3.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.3.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "24f60c1de4651c21c446ac753a315dd52bb122f339329de7ef0bd70d5db9aa03"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.3.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "08252ac55e6fdd1c3ff81b541b58f8b127d1b421e7052e9bdc7bb2ef19f7a3e1"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.3.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "52e367af567003b16a5ca4f537e0db4d74d4ed0b294099fb35efee5fd6c1b5cd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.3.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "e95c2cbf2ffcc6a1458c1076165590c02bb70261184bf1132cc0d79f198cb466"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.3.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "db4314d71f9341c6a89f8b264567249c13ccbd600c2a9293386cfe885e556c3d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.3.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ec088fdbdbd7ce79d9cbe6b12e41bb70d3a1dc5d533abca3e7ff77a5412c738c"
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
