# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.12.0-210.2.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-210.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "fbc788bfc92cba6d528de64ebf33eaf0e4f906838e4e33d5f95e19333a8fc8d8"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-210.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "163135698950945ce1225c240d6bb0d7ad103e9dfdba9ca576f44b7135a17eb8"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-210.2.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "05e98e982c48da88caf2d78390614eca1bd65120dfccd372bd351763447bd7c1"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-210.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "3afa7b71afac0e5b2cb1a10acd70ce71603abd11e659b68eb84f5c8808671f66"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-210.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ed6258c16b66e924b0d9e67876ecc2a8ddba7d2915135c612b8f0bfde57ca000"
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
