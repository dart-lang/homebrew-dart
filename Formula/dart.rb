# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.17.0-109.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-109.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "dbe63b2a45fad5377ea01666d57df8eea5ce18674fd3772e3995f172451f71d0"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-109.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "a7133970b5cb50cc6733e1e1434df668eb6e0e4abec1b5abdffb4203680e1801"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-109.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "4e6c4798210aac5599754017aabcdf440406f8e729ee9bfd349a00ebc0cad00f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-109.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "627316eac0f32d28535dbecbd35ce4ae66cdbcd06ee7613f967f914326d0419d"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-109.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e83222f0b5645dd44282e48362d3248acabbd9609aef54cb3891d1962f68e870"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-109.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "15a9fba8de0f0899d22c9924c041bbc630b0db7ee59d26faa0966904a7ffd211"
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
