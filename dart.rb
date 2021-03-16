class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.12.1"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f2fd4b50fe017bbad3ae4e3fa1f9b170c9ca25e87b16f80c0c8e667caa0b3568"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "66dd4e090b34ed8389e5e32975724bb9c4e0a4ceba812c2a2f8dd9565361a97a"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "8756f5011bba0be2353090748eb68143b8ca72fa28391d201e6dbf9967fea9d3"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "6b54c5ab8e068cf6e99f91aa071dcf9e7dbc349b3f456e0b8e111ba70f92d244"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "450db68dea032a39a4af942446e42bf6e72a1db3da36fa1799df56b77bf432c4"
    end
  end

  head do
    version "2.13.0-116.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-116.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "eb3d92ecea1f254db1d40dc55b992e79cd825de7bad5891c6dab58f1ae6d35b4"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-116.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "a6414c8f9e5208b90c91198062ab7ac0d878cfe9f99c2e174690c52a94b63670"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-116.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "2639499b9d5fc451da4a7e91d7d5caaec579abe8edabb5fbdb9003e811051017"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-116.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e70f35b8e33cdd26ec3afbe82db0d371f8f69d85bd3bc549c1cda2b66e29dcdb"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-116.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "dafacc617d64f34cb48213dc487f503487c2d75cdc9dfe53e5e1baba1cc2456b"
      end
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
