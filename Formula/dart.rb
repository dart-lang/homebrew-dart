# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.3.0-279.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-279.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "90cace378b21c86adc0a65572c064ef8b76e199264399d482e0e04886a52d612"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-279.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "8966d364ff659f3934b735fe43a40ac3602004de519bb80abfaf5ff867c84b75"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-279.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "0de07a2e9880996ad4fc248914a492a02394bc4c547f2c03867cee55d7b1bfc0"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-279.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "4e510e92d48f1bbe20c805f8793f7273f3003adae0e9f23ea8df53495654f429"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-279.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "5defe784fc88f454268028e3a00523d86d1c4f91983bc381e2902e7aa27e6817"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-279.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "0b6c3c0f19c2af8346eae4856239522a518d7ca9700300474fa033af77066583"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "02d8d72d7c3905c5f009f26e00ab9b787d187d1cdafd2066e1bd12646ac1fa80"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "4b69e962098dbe1de2365004fab48a1e3c8302540df2827ceb60445a6a634b22"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "7604c091455b7c3e4b3f52a5966b07f4accb657954c54257fe84cddfc77379ae"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "f1a17787cfb3eacc205bae68549c4339048d092157d285cd3dd4afa3818aad49"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "5a3084385df7014fea762fbb8cb985364f65a041a1446db6955cdac670cc8038"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "7b9f271fdec969529402d793b6a5d4c4006b986d027311f13b213be3199c9869"
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
