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
    version "2.9.0-5.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-5.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "ec82a1f0bd09ebd4659ca1646f53017da7a78575288682ba7d34a3308378bbf8"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-5.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "81fc486e55ded377a56949c009a279cf6d8cc77a2dd497783c823301145f47a6"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-5.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "b7bcac9e678f55b71856c918e2344c959b0b8e1fe309542475054e8e6137c450"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-5.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "4d9deb6b4e748cec996bcf8d09fe8364442e14e3d1af12674e527875b95bf403"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-5.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "68200ad9b71cd79d8dc14508617bf0d008f26c8ab68ba1d9969a1699fc9a75b0"
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
