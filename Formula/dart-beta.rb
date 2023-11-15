# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.1.0"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "6d266b1c13fcda9220d0fd1d37359978651e771fc37468d24a9c83a8455c3528"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "99bfb297bba2dfe34dbcf0a165750a23ca91172eb353a80a46d47084dd86157a"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "4ee368d9d359a6bd02fd0b617c31cc038373878260fd58e5575a29bfaff47773"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "8d210a882a25ade1fe8a19c04eebb65b2700a5d5840067c79ddf8962a83e28fc"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "6051c47c73ebbfef227348635c53147cf234a4df43731c10e74b72297ff95b14"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "643456fb31441dec020240e983c945d5dea2aafade865fc1aadca40ce4eb661b"
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
