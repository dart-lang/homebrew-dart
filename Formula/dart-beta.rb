# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.15.0-178.1.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-178.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "630ae511b59740ec05df23f9c09bbe69c6b8880f9bc1a90079a8c7ca52f2b98d"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-178.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "d9106cf01f2c9271f5a77b086f37a078a00011740aa47f1898249a6271672574"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-178.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0aa79c07ab059598b434fce574591ea5e318aefc579b3fe0b27e985fc5159270"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-178.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "563b38469df5bb20f221ba8d8dda13311cf84d5c06ece93f68ed65f274832743"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-178.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e62e1ad98ada15b694641868c6d78c984796a12fcad74635db3527844130c875"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-178.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "4d0e0b9c0f30ecc2f65c4ff786948d99a06fa42a9191fe3be63efc56d40bafae"
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
