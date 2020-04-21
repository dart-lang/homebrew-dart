class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.7.2"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "529281db2b4450c1aabdda0e6c53ccfa5709869dae56d248fb62365c0ea03f84"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "9b1434cd60c56aa39d66575b0cc9ea0a16877abf09475f86950d571d547b7a6f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "158d984c679c0099f8e099ca351f30ab190dbf337a8fd30b63e366ce450b4036"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "57a856e0fa199b6c9e80182a1a9c5223d2e1073be6d5a6eaf560cf00db74c6dc"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "dbab7fe86ba5b2a8b4c99ea7055bf8bc681c7804503b844a9ff1061dce53ea12"
    end
  end

  devel do
    version "2.9.0-2.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-2.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "6b12864dd37ef202e180da4ae3a2e0216acb13fb91c23e3088bc2dd4692e2f83"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-2.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "401830cd4a0cdcc919d28167c31fb9f6f98add4f949a503d8083e89178f4832f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-2.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "c090bd3f15c6cc84a786544eba08f6f41e1d8cfe419a184f2ee083cc38c3f554"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-2.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "b70267c2adb46aec9fe12f09c4cac3fd9cf7fa4714ee85f570f0a7e28faeaf79"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-2.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "28b6c9aa483ddfdddb7e83887187a5de8873acc7b275b8e1f643c33395b0c959"
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
