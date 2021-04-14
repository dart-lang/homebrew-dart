class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.13.0-211.6.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-211.6.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "83d2a2b12415047f27951af97d775c5444eb66d4c8440741b40287720ee1dbfe"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-211.6.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "b91855a45cd101c41728e0e7031e6cd80cc4fd64d30d57df95672c8941f72ffb"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-211.6.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "39703aed3df7f5e79a14ce2f84b83abcf2d52045c837030b78ad6701700d65ba"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-211.6.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "214e26da0eaf744b756f19326191d491debf3ced3ab5b86caf7b44bbaf5fd5a9"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-211.6.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ebebddc947e270b1185b51d47ca8bfc1b78483ec5cbae01ddb59fc2fd0ee30f0"
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
