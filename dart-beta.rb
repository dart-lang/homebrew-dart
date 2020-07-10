class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.9.0-21.1.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-21.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "04b67fa5b2f8dbb995d407a029013ec5fd606495faa5644bf90a530a0686b07b"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-21.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "bfb68b95ce018e14603144da985f228df260099217c1d9f9b19d90db6333d970"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-21.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "00dc694a945437bd75f01b4fa04d35a1dcf63ab992a25bb1febca312a7c42ce1"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-21.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "df9362c6f349c06a2eee2ac597dc08d3a8f447e2f8dd4c04fa7520d5ebe44cd4"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-21.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "7c730e4452b9b881fc66ba522520275c1f3116ed3e7ce611cb4828ac6d222f10"
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
