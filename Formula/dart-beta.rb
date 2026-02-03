# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.11.0-296.5.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.5.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "901e0fe132c6bf81d0a9bf5a8798c78a40c73fd3172695d131dc07c76a1b8acc"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.5.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "4fa845b8ee824a15541225bee1c3e3832ed68e76a180eefcd50fcebc97936b75"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.5.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "eb9219df3dd42f13ef890bbfb0b68a635abae5b749d6bfe4ce9295e03c72cfe4"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.5.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f42a844c29c593569053baf722a65df0ae63d3a76e3c90ef0604edd8a9f0297d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.5.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "075a1ae7671259f50ae82df7e9d95917ac39d0253612e69e030bf55a8d382886"
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
