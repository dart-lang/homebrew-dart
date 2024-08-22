# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.6.0-149.3.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-149.3.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "09364e76397a21d08c118d1d4884fb8c6055ca8dedf43ec90bc38a2d5ad438f1"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-149.3.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "651d2fffffcc4e7c731ca629a14fda7d0b79a15dca4f101697c0470068b73e93"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-149.3.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "fd2480f5500a12d25578b15955e613641c23a4cbf6505054f8c969f3c7255b3d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-149.3.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "b2e6870e858631d17b34871a64bd92ad0e8caffe3b65195d9dd07edcc09baa42"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-149.3.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f1f37f6df9922fe0d4897dbf70766591ac6d37447e9016e41405a8abe160e51c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-149.3.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ae12932960bcb44914df7d913eeb6b422c3c5b55a94310748a1164e036a32845"
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
