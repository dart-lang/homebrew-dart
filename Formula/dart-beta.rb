# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.1.0"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-42.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "30549a3fb4fcb30c756c966308ea14ceb9c09dc2c99b99ba45a1d28bb3eda0aa"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-42.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "9e09938b2ba945e01595a09246134faaf272c759c815e8051402d29c1e5eb76b"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-42.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "914791d2402bb641a30678ae089d1ce817a7f4722e148220e1aa00ab32b2cf85"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-42.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "0ae390f95abe007670fdb6ad2ad6e1224e84adfea73b2414f93fd74a55c5e348"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-42.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "8bec6e02c2fcb8c27c5a0e270072bd24dc594178b5245b19edb3391d58810c1e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-42.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "410bb11952cc077ad4e03bf28aedc4d12a7ba3a546757ad329fb7fafccd7a46c"
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
