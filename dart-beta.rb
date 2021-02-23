class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.12.0-259.16.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.16.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "55c5b3601dff0c0f25e4a9d32d96cba95a1c6d790bb30fee97da3741b956c9c5"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.16.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "37e5d434da1de5b71af41c74fe0cb35a93e4644b545cfc07f9e251a812f8c70d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.16.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "f9efe075f131e82bca413d6f99e0a2b94b25bebe186dea15a15ef406ec76632d"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.16.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "dd20f3df24a9656ca93303b8af9dc0a02257577330dca89b83a2c6340043ec7c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.16.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "01e120487785adbfdf8509a285c9839ca36236429cbb0f8eb79cfb28679231ea"
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
