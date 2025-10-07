# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.10.0-290.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-290.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "059725b70ea38a7565d1376743e106648a9e2c205a79559f532669ea8b1a234e"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-290.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "944604e916a6cbd4f536deb45cbc0c62fcea90fd77fb39110b2d4c688d7e8309"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-290.1.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "45ca9d4fa15d67c9a25023eb8f3ed675b73270ac38138461feb022cae54c8e79"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-290.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c6714abdba28cd68b89389531e148c4db7ee40a69de3cfbe28dc44fc27fa915e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-290.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "c55d0181b5710d02afbae4e1222ba55dd0852d75c01f2e9ab72f44b672776afd"
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
