# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.11.0-296.3.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.3.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "687a7f540841b594e774e1ff7d85407cf4d18bbacd1baabd2122d553fa1a21aa"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.3.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "6e0e48d145ca43bf7a2bffe2e5a73bf69ef74577fd636b282d1d434c0c5a4148"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.3.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "bc1d7139fda640af2f0039bbb842901f61a88ef59a20525ca35c6a6047163e76"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.3.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c06fe3aee69a0bb0ded664a28eba38176558ccbe69a8eb6f0d26c700956a5fe8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.3.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "be890d3df1f4397a25a3e3104e252e2421166a1b1e88143dc4dac72ae1682c50"
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
