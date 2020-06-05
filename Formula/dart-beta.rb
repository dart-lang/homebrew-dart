# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.16.0-134.6.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  conflicts_with "dart-dev", :because => "dart-dev ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-134.6.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b8f53bc7d14dde43a01b403ba8acf701a8702751df92631c55f1a9b1744bde94"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-134.6.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "2235f604217b0317585b341d1332c816b4e78d15169aac605678550cb7411b26"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-134.6.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "315767a7242ad49d9003a5d4d43ebd7bbe8556c7a7ac1dbfc160d71216b732c6"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-134.6.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "fe4ce12f717da2596a57b3503b52deb2423fc8591cac27d438f2f1757548b2cf"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-134.6.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "95312f8e1253b9f67e800f4949972de39ed4870681c4544a799899a75bc1bdbd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-134.6.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "4be3da81f0b1736476f8af0ba11a1874d88af9770d55ca4e116717fbe028e547"
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
