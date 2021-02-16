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
    version "2.13.0-38.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-38.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "73404350cef4766c250e3f90a0950c213bc30404ce3a6f199e46e79b64338a74"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-38.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "0d37c344baae862e031d6edf937e2d7fbaced0b76259852af0005326d1e5145d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-38.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "8cab0b3072ec5a563aacdb8bd0087ce56687213dd6f01c889bb62a741dd30ea5"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-38.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e0b0138e38145caec38b5c4ef9f73e2c9bba8d242fbde08f74f72343def1c48c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.13.0-38.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "b69e7a3fca102680db9dda1a9b322e2f15555799684bd6950dc89715586dbaa9"
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
