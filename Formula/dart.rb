# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.17.0-162.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-162.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "397bba9cc9a900bf4e6809596e015857d79abfc1fa8a1da474b2fbca02169d77"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-162.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "bbca95792c313b53c15d9a789b9f4d6d03bba0af897e07d7068ae4c0c355c52a"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-162.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "da9c88ce385de59fc11c157b82194ee063b464461e7ec349cfa2cd3a2c0b9cb6"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-162.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "ed8ac755e87c127a01f8686cee78844d4f3f55e34dfe341efe5f0093560c4156"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-162.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "86ab2daa23005a618f6b84bb0addcad58a26dea005186f54918b676fef5711e3"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-162.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "b5ef4a0d8cc752b2fef081f10af07a03883b85ef3815a81c883b6fcc9164757a"
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
