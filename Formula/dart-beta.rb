# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.12.0-210.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-210.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f7c38dad892670f47a31f86ee94036fe209a3a36bcedec00c70290fdd681a1bd"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-210.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "2ecd2cb3381e43ef0d2bdba3c547182906a7c0683c5281575fa0f8650cccb0cc"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-210.1.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "953b618cdaacbabb22678fb3543510b8d2b5ae124e360a80d85858abe7b11ec6"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-210.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "4ce194b74edcdef1db97682cace739a74b0a1c83b1ea5ac270beb6e1463d21dd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-210.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "6b30e245720fbb0585be6941345ca7313036f3969c49596c0f2ca7675aa027bc"
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
