# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.13.0" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "6f75f0d6bc10c00457fb5b8861b26eadc5d883cfd11aa26a8c4f6353af370f47"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "1812d602aed0a9cf7281c93f514a1e1aecf60dc345c4337dba4ff28fa8d398ca"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0/sdk/dartsdk-linux-x64-release.zip"
    sha256 "87902573facd8acacac7ee1fe73fa8d0668e06065016068e2ed6c5c99c6b1ee0"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "20141a0653327939bb20c4b87b231226beba1128d8a9aedbb30cb5af1a2790d4"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "d75787da6fcba9362ddcf0643443b04962e280ab09dc48b05ab49e6538e013ee"
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
