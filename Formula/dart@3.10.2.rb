# typed: false
# frozen_string_literal: true

class DartAT3102 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "69c3a210ab44fba970d1e5f16095f7c8d5f411909cb26366df98fa19d64fc1ee"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "8e7c265a671ad3b1138e800c0cd67668390a745c024b8339ede3799e8a60e757"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.2/sdk/dartsdk-linux-x64-release.zip"
    sha256 "4d1582f8362f16308f09df2cc9fda05f7fdaf475e639b7881faa01628c12fd55"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "9c4a5d4de58dd0dac1f8db0c7c642916f7dcae9d2a7e3332cd3d5e869d10010d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "c5aee772e3358f358e386189eb50fefb6c3b3f7c5139e9efe19e76a1f5fa2cad"
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
