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
    version "2.13.0-21.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-21.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "f21cf53a9da40753ef6d2b2a753bda709bac2a16d22b49eba7626661ff460ca6"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-21.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "17856da929bcbdb7a5866c75ceeaf5e21da961e06ae30f3a4d673dd231fd1f8a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-21.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "055529e8fb02ae3639404a3a8eace7db26a805c49631dc6d92d61f0c6ed9c026"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-21.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e941f9d65aa90a37ecc86d75e157e62f0185abdc0db8b3239660aaa035f6b9b3"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-21.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "276ef5e5b464c50c79d5b897cb2359656075d113b93df4fca77980d6dc25b75b"
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
