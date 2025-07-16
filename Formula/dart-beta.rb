# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.9.0-333.3.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-333.3.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "574d6372cab32da0d51d5f2f3dc23b7da5745698c7d34e60dc2afba55bc6eb01"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-333.3.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "fa83206f3632b45674a731431d16e6e9ad2f8bc48ed45e7c24c93e5aeae69297"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-333.3.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "f5be518d76f251417bb9a99028d6174e84c4ce4f11c267a59123b649fefcf67b"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-333.3.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "19a179357a953fd21a563c2c0b2b883693f97748860102cd420ab6e3a1d72439"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-333.3.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "769b400da087890ef3a96e2102afc65c7d8d0f80231e021117860ad04bde2c6b"
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
