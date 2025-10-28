# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.10.0-290.3.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-290.3.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "15a136664e6354946040f2b753c437d52cd42de25e2325d14e629ada845fabd8"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-290.3.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "e0b95d442ff0e63093f4d4b70002aece86baa49a8fa434f992649092da8fcc96"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-290.3.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "f34786de7578862d7d8718f1d70c983b90e7ecfaea29599d7826649be7f0efd3"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-290.3.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "868e2f477c4bfc7c894fec2dddd061a4edb12d7b7ac39d2052e83ac9bfce5bf9"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-290.3.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "649d5e6e31f6189ab216214c0f286e6e5eb74c2ed7e0977f9594d9742afdae5e"
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
