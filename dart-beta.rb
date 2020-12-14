class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.12.0-133.1.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-133.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "dc4ac7a4aa0e31ff870fd086dc19d7fbdae14e79ab86ab200a12c325d3e8e55b"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-133.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0d6f5119c8ca3957aaf01a410899b69867b327f9fa071259c79488a76a3bcb1f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-133.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "ec0dcebe955d1de679bf673208c26d7501c2396c735ff219795d6b7de7ecf4c2"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-133.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "cc9e7f4e0461f6361a589803b2038d300b44afdf81726f064256da120846a1e3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-133.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "d0742649c49b201a219629eb3f02d0e71eb10b9a188e2ff15d50971805e2e0e6"
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
