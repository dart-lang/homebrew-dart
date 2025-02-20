# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.8.0-110.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-110.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "706b229f64a06214ef2e9a363b93e6887b1690c73994d4a163abc175546242fb"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-110.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "29ac3d8154266747d06064df529c5ad6731244cb043b67ec2c91d64e02514efc"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-110.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "e762092eed55f307152421044f9b49d0f2d86299c92489045aab4853fff4d1ca"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-110.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "45dfdf950a352fd34eaf20bcad115eebe5489eb5329ac84e6e7cd8a6fce79d26"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-110.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "86ce96f526568d8e9272feb16dc86d0ae5f46800edd365963adf8350870fe007"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-110.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "dcc38aa0f7aef0e8ee3eb5891c39ee7d4446d69439393d27c0b5abe219d2e241"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "d601c9da420552dc6deba1992d07aad9637b970077d58c5cda895baebc83d7f5"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "9bfd7c74ebc5f30b5832dfcf4f47e5a3260f2e9b98743506c67ad02b3b6964bb"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "367b5a6f1364a1697dc597775e5cd7333c332363902683a0970158cbb978b80d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "d6998083720f01825b7d75bece26cc11e467edb3e8b3b46d02dfc1e01b06d52e"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "7c849abc0d06a130d26d71490d5f2b4b2fe1ca477b1a9cee6b6d870e6f9d626f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "03842c2037f99450a1433f5dab9dc1820686eadf92f517929d0306cbbe92ecd2"
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
