# typed: false
# frozen_string_literal: true

class DartAT3100 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "5616af41c8356f9d739cc1bc93c1a6dd4a3830fb0879d5508b1493de24e9a317"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "d09fc933505c36f72a92254a5796028a1c5eafdeb8b9ebfac62000a178798a0a"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.0/sdk/dartsdk-linux-x64-release.zip"
    sha256 "a27681be873c3891692285db8d656e7494ca80c74e86613b8085fc6cffa3e31d"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "688603283b9a9e7833da53eb5b3a07d78fea9c51fdd925bbfd922775d4ba5ea3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "b91536edbcafc0d6389b8db6d1677bac0c608a1578fdf7c919b47b439aa044f1"
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
