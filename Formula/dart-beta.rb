# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.8.0-278.4.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.4.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "68a9de0a04fac3c1d08221f20d4111169e5514a4eacd823ce9da2c3c8876ae82"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.4.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "cc3f0e15e83e42418323bcee81d317418dca9b3484cbe6a7e932d516839f38d0"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.4.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "1d62442e683d3ab36209e028cc4a349cc9253f41d2b69acc11f917ad3b17da65"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.4.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "14810f7fcd92b788b4bb7b4552d618e85f6d180c5721020289bedfc1451606d9"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.4.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "6b936c0d83fa51ea5f8ea0e097284df38914abc281c91fa694b2a0e517eb5f9a"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-278.4.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "6b492250bf16fc843a391df83e2129e446f635c1640267f9e4d960824e911c18"
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
