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
    version "2.9.0-8.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-8.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "ffd05729035cd08c1998e87a24a49ba9a8372462932d6b05d802ae1d5ac619df"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-8.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "81d600df4bedd92a46b56578646c27ccdaf6d66f2f7b541d7dc25c3f1a2f498c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-8.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "8d7bd2ce3708e6fc66551991a0bfc828710ee6d1bbb212b62677593ba2e906b1"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-8.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "9c30962d6d501f6804ad120761aba26ef864f5e8bb014e48343df675b189a3ce"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-8.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "1f3bd0c2c7ed8980eefe52104c77367356803ae014e2ab502f6e7d839802dda0"
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
