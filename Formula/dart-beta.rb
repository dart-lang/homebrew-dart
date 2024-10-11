# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.6.0-334.3.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-334.3.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "a9822765ce6e9db98479744f963f40ce32c4cedbfdd38bd412e4acee68b75d10"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-334.3.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "3e9f1e9a15f8915307aaf1988cc79ee2bac651a16a9d850fb58baf55e01e2a4f"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-334.3.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "12d8e0258fbf50cb08fcf79dcb4aeec24c26341c97519ce8de8d48009e9867c4"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-334.3.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "a18893667926f1710d698a6374a8bc4e3dbd70882a8b770118b01a8f788753c0"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-334.3.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "1e8e40d5faf45f16067b90f618043a51bf7d8d939f5fe52eb40d0adf9887cf4d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-334.3.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "b0b37a0f05a11890b41e5840d6ed9cfcddafb28ad38481f56a8b423588bd0b40"
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
