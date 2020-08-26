class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.10.0-7.3.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-7.3.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "5c877885e50d539e9e8859c0347d0458cd59c79e503b44be80d58601757c029e"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-7.3.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "6151a4f53ad68c8aea299fa02d20a84f890804b00a5680132602a753306776a5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-7.3.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "28d19653d6abe5cc5aab5e76f9a4911b6990c4ac116c6ee7af21f0c23db56d33"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-7.3.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "4c6ac532309e1782441bf9f0a6ea8d3ad7ebb6ffad63ad8f4874669e399bbb7d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.10.0-7.3.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "faef17f06e7fd91ac3d961554e38c18fbdb048a7192b209e7205dec8cf217bc3"
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
