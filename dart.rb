class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.10.5"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "31a507a0baad581704fefee2d37ad7c028970c4e56799d5a0c206dc38ba862ed"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.5/sdk/dartsdk-linux-x64-release.zip"
      sha256 "5037a2c0fd631afc1e77e8ef86fe1ab60420d810cab67ac86f4179d9f7a866d5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.5/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "c7319de95d1e9c471d8dbe80ebdabc0c437e5ec21c7814c96b79a9ba79c6e481"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c5cf15f6cd6d2ed5212a0545936d59398a8366878e90a022675c9b443c1f484b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "12db2a878a450586da9cba8f22adaec23ae2d7c8b4838a2be58687c28d5b6814"
    end
  end

  head do
    version "2.13.0-93.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-93.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "3db1ae2d290b7d63b594ef74b40fda2a9e1a756e8bdfa0a38809e8ddbd51761d"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-93.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "b58112b00949037f5594450ab68412756b7d43f163f0e156f7564dbecad3f7b8"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-93.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "b5da09aeaef4aec93fbd1b35c3ccd682806acda6e6dbba880d8f1fe6604b31eb"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-93.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "4475b21e636c07433d4498c8dea624eeb11f27686c34c78a249e95711e596969"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-93.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "1b93eed6885a4c9909d149dc321d9a351dc747304d6612637176efa3dde63be4"
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
