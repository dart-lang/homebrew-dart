# typed: false
# frozen_string_literal: true

class DartAT392 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "4c67a5e8ff687b0e5aa3c0c0312e640b12e5d5e9278d91bb25cec0df66287d79"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "01d0672db82666f72f9452df38ee1516a72cd9bc29818bd3eaddf82e40556152"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.2/sdk/dartsdk-linux-x64-release.zip"
    sha256 "ec22e81271582def81d3e10e2a555ae5d3d81c6951465a3d16cfc47938e9f92a"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "d62f75f3f1bfb44a22fbd5cf0a5b47c758516ceca5dcc7bcec88896e2583e7ba"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "6b7d758f64ec94af2933a0d92238339eb9e179a0d61ebd4f9095ac675f4ad263"
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
