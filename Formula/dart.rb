# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.17.0-91.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-91.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "75f3d601935cb887581e4a99e6a1e746d40bad5eb28141fe4a759a573f88175b"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-91.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "6031eff8c22d19d3804e4a43f0f026a5f34561c1250a9e3b1f4bf962bf37cf3e"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-91.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "1d028567e8095deded6d6941b59fe2a576f54cd2c23a928e0ac1cee3718a7f21"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-91.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "f7a1e2b2264c4ee2f3ed9fc5aea79ef514702056b8753084ab21174d69c62fb6"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-91.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "fd0df089f07c5377c01505efce1bb548f06374bee7bc933710ed2d1a3e933389"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-91.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "2134added6e7bc6ee52860acd4b104814da45645fa660a02a762668a6d468d07"
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
