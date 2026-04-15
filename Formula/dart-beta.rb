# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.12.0-327.3.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.3.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c86aa24acd4f73ee8c1f4b84668d62ba227e1fdb8b7e6271299a6bc47341d5d8"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.3.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "e0bd66e5f865ab67e1bc61f2ab56cef9a5e8b9b911043256b8c31692a296c5af"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.3.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "64567d16674aa558a059d3c1af2dcde5fe222e166d092b11a721285d41361679"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.3.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e211c35ce943eea9f2038c0ef351bad325ba959d7c58cf4e77f6eacc02389459"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.3.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "df9611c016da694f1d36dd923fc392bb1d5f9b3b5b8bf93d2367afdeb8522908"
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
