class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.11.0-213.1.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.11.0-213.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "570b01563e161e4963c8509e35b8033db29c6650b4580d8684aa8ab0731b171c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.11.0-213.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "c751e16f601271582d88fa2aa80a8e9608b76379dfcf74c3fc2d63e10952032c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.11.0-213.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "2993640e09379e5f37addd5ea8e465c8882eb14f695cc4dad39d0880b06b2af8"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.11.0-213.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "28e4499d6587d1e3058453a660b3e1aa59adefa62cb57da95e13c145c07ebafa"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.11.0-213.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "a64192d93e4810a5cca8f56a83a12dd6024785da743a64ff73d9acbb59881033"
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
