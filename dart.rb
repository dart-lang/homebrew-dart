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
    version "2.13.0-114.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-114.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "498064d913fd4440ec96433a4f2db789db58f3a6135eaa92540e5ba1de3e092e"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-114.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "f5cd4b6645ae9ea942828698938ba919e20bf703e692bae1726135634dea8ecd"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-114.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "602f55cfb342eb333087fd34a0484755567983a0be3a1fd6b2ba5728409f103b"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-114.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "30fb97c7ae0bb5c89527432645fc461527afaf6a08324d61053aa41f1b631e79"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-114.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "db735931b43275c8f9109fe6947949577015e2110a4cd6190ee9f98c1ab6a3e4"
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
