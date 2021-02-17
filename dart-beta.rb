class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.12.0-259.14.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.14.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "5aaad7526cec4813338e2306ede622b6b03d65cb9edf82ceafa629be9a300853"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.14.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "531b9724defdc3924e925bc94f320e6f92c5bb0e304c69d1d13149dc672c21bd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.14.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "05a272eff43a8ebea5022bbc53099bf873a24eef4725cecb6239a36274679fe6"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.14.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "a658bb105a19139c190bb0483430ac1bdfb7a2615f59d449b22cdf4b9140c58c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.14.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "9508099a7042677e910e32482cc0d2d462c1ed7af08c7e9ac131b7e1c5bcc090"
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
