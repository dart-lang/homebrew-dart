# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.12.0-113.2.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-113.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "ae0c110f9d4abcffeabe2ff514bcc10499a3a49b45c769ca46c9f8b8aee23a70"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-113.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "bd94a27ad914c48c67021048737e56168a83b5eb870a1f797ebe211b1507cf88"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-113.2.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "0cde5d4d710532c9ff01dbbf94c7bcdcff46cdd7f376ca10befa0c697ad05c3c"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-113.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "5eda41ac9adb63fb887b7d4b2a1def316560b8ac3c06b80860e8fd589a0d5150"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-113.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f1d8494c38e400c484f697aecf97da0a2dc584cf4104dc18012ff5511af4db39"
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
