class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.8.1"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c94e03f9f0d4fa90e88ec70861b2b0661a5bda1aa4da4329c3751aaf0b4ef61a"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "7ec2c65ab140066aba9cb85254322817e698df3d3f49d5835cd0b3d1139fdf93"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "f0cf290579526237bb8e8e2d205d1de61c8629762a7e763fcc04d7552b5fa370"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b01dc83b77b8eddce33e18ae35bed98e18faae77eccff08178a21c9ea913ebb9"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "68ee57689bcff7cd7341db05926b291fbcf5bc2a7fea9d8dd8105b8ec1a73abd"
    end
  end

  devel do
    version "2.9.0-7.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-7.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "0d2a75a458de5c295a47b199124159749bfb9113277984a7e0d2caae1904b03d"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-7.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "26e3dd85ba0e0de91fc75715d5e0d9b91551c20ee120c66c8be73eb96c33c53f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-7.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "f66a3807fef306f9e4f43fee19eb7bdead6df71a1a8a1c36e12883158cab8e8a"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-7.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "c39fd47fc0f5745b843ffa90bd44cf0c610ed830a9a55d8a0aef132aa587aff5"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-7.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "fd92035d4227178499f080ffba4080cc64a24dc49e6bcf954b8ff70ff00748f2"
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
