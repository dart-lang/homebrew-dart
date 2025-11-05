# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.11.0-93.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-93.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "417c9b8ac06423966bcd576396a241247478a2e41e372f4d02f46ff4758d58db"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-93.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "22d0741bb22a3cd2115d194eb787b3bdd57b8abd7ada297e9258edadd890e67e"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-93.1.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "4becf5c692812de85faae19461d64078094491b34e58d9d5f36bd0f8fc989866"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-93.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "24dc3ac9faf1baa673a106586dfd2682739ae060405fa3f1cbc991b4c698904e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-93.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "378e6683e3b70289193fb17052630ce0439fb3b5937c52aeba7718c371c04c8b"
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
