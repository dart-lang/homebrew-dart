class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.10.0-7.2.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-7.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f5a71b7f7e5c437dcb6aaad6497bbacfe5d9393f844cdeb2533a21a4f6ed4655"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-7.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3999485fdc171aa948b43a33d10737004ef6ff179e3f881fd36810a00b22ad8f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-7.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "38e90fae14ccca326c846676a27e6883cf47f54a14dec25ecf755fda7cd0b871"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-7.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "89d8d1402403f8a7c0520a7171e6f83f4afa17c75f19d41f483e114a12e2cbec"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-7.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "81377d4b432e090cc1d23cfd3174fd1d76ca7407eaa6d85751e51d1bf7ac3d7b"
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
