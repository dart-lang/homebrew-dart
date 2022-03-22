# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.17.0-222.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-222.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "ce98866c4c827e7adf0d40db2e374e7de6fbd4b57625db7faf908407ff914048"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-222.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "2deedd47e28d21a93ee96279ffa39c46c229cfadb11bbb5a17c6f4a43011f075"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-222.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "3f6d9614ba0a92fa13f65c75aef2d0c16ccf51868a6ab8846cd259c5774c7cf9"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-222.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "c7558d2a4d0373b397e39989467474dee3aed190042f3a7e799c07075a1dd285"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-222.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "970a65c27b3260c7ffa169e6f7cf203c0699042cce699a785c74eeda0c2a3fc5"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-222.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "88084d26e872d8be58ad43b037e07daa3967f3c77257df1204844c8f5384a9e9"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "5c5b5b9f752ce78e7bf6038627cce8b46d8598b4d74bf05a1d226209288bb742"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "f119516d746b9b10358321d12899444015fecd0223b7add9282648cb57b64d31"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3cc63a0c21500bc5eb9671733843dcc20040b39fdc02f35defcf7af59f88d459"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "c2f815b2c6adcee1dca7d49efa32b22b791b3d10f965fae8f2cebdf5d8d2fdc0"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "de9d1c528367f83bbd192bd565af5b7d9d48f76f79baa4c0e4cf64723e3fb8be"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "16e0143716b3ad956fcec78bdb15834bcd67619e61ced0a7806328e9d385b2b3"
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
