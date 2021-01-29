class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.12.0-259.1.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "2620083ce5ea476199d667baedefbd68a00b5dd3a8979a4d011a8a2c4579e40f"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "5203d653de7bba447263bae0c16d8ef3e460b7c918c16cbea487a78f4a2c6d7a"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "b052da680f24574b732aaba0c77dfae6df0a5a364aa7f45e83e825695fa90191"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "a6ba819fe8d9afaff8e16a93eb1585810e9399055c3840e6081e1eea96cbead2"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f041d3e226d3e82f91c7ae50e614d0e55b9457ce892538bd09b56b15e8bd564f"
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
