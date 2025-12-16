# typed: false
# frozen_string_literal: true

class DartAT3105 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "eafc1e0640dc96171f7fb4289eda365b0c049488bd06a8a6187d516cea5e3815"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.5/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "4af60f9d5a69c6d1460bc72cb599bd236f8b0f14cb9f773c7cebda1604798706"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.5/sdk/dartsdk-linux-x64-release.zip"
    sha256 "26fcfd525f0b321e3d77f89e1c994ba855bebcb0d9bc2a25043bdf320c5e0f14"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "4e7ff12dca0ce9a2eba6635a90b74e63dcb8c72d4e055b8e0bbc037e871065b9"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "012bd1693bf3d1b9e41c4fdd709812873efcec03efde15392e09c374ba54b95e"
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
