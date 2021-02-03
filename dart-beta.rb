class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.12.0-259.8.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.8.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "9b82fe7f72611b5d06cab8cf8864f9a90b9014be074c78740d61cd7851877049"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.8.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3f99b4bfc3ddb9772b231bf15e8f271db623fd99fc89aa76eff684f2c8188e33"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.8.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "72703bd6ae123b9bcd5b5187cc9325d1af5e10cda7bc4d99d22246b982b6c5f0"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.8.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "2585e586dfa188eefeb2d47b1ec6ee2edf4345d9130153c3a669f06460633c5a"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.8.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "93f05f462ab837bdca13b18bf72af1c6667db863aa417fb3064d02b924a8ad3d"
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
