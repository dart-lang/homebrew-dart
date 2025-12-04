# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.11.0-200.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-200.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "bda29a63674a010cc2649c029db72454638c603cc51cc42fe948130b29cefa4c"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-200.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "03ce1606a268b69e324f9ad7ec8c3e4957409e25f0ee6c1cee991b288b1ac00c"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-200.1.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "b313c517bbfa7a5b726c6a766d6aa3a74fbef75b6ae8435a341a6c892a1a28c3"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-200.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "4ba60cf02bc68bc524dc5f75fdb3e65f36d07b4698bed1df1de5b4584c3872c2"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-200.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "783cb6bdb7dd7991d15b2cf1c31eaf69d29f1bd3469fc4d511b7599eafc9305d"
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
