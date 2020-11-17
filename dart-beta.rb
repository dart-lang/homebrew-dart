class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.12.0-29.10.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-29.10.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "9f0ab343893567ce867bd3438fb8db8ca3cfa93468076a417bd1a613d0f7d336"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-29.10.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "de0aa6d95568463855450537000e6685f670f3144361b4f9f5d5b9f6fc10741e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-29.10.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "7997332b2677807187c21d3acf765a702e5e87a567cfd98affea8138af5b867c"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-29.10.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "7f3fbf67cf1cf1278c765dc704fdbd371ff923acf1c02c7a1c41fabd3d3fa7cb"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-29.10.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ac6bb9f06ccbe08ecc2c8d09e2ba8295f4508e540d6015b3e872df7a6701d844"
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
