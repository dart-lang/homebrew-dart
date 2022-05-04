# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.17.0-266.8.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.8.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "36f2ecdeed6f513840863ab7914928abca765d72393c64f0a8a7dc0d4f4a316a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.8.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "8a2c2ea134c90e4a2fa6636ddd1080b265e35a49c71a64f5ba5468222b6b2257"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.8.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "1cc4f69696674baace0a7f1b99668633f9fca51cfa1fbe716cc97f8289e59508"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.8.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "92c529233b602c1ecb28fecfe5905fa3a6b04bf00ad7c1c932fa801ba77a7cbf"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.8.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "18f98494af1e6d41fb0481ee010aee54b3ebfd72cad313ec2e067c1bb37e1968"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.8.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "e86ecd5f14c4a0de28569d3367e68600f1400c4a9a22792bc926a4368bebdb6a"
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
