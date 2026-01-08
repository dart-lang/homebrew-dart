# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.11.0-296.2.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "7b4bfa66e0c7b11d6391a0d02423755d41cc3fa0271b6a703e0d76eac56d7cb5"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "438de6efc246e036c72a7bed2d3ed835248f41ac09c7f25c2c8681f04a5e534a"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.2.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "edd704e758363f4e91f7e331e8c0c1dd6f65459a2c45a12ca8800c98ea6aa994"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "30b6e1e200a55108989e52094186fbb3f71819c1d75ba1fe9f084f8b77930415"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "668f984cb8252e3b1ad067a1fee4985a58453ac8575042d4c12781297f8b7f65"
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
