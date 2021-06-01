class DartAT28 < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  version "2.8.1"
  keg_only :versioned_formula
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

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]
  end

  def shim_script(target)
    <<~EOS
      #!/usr/bin/env bash
      exec "#{prefix}/#{target}" "$@"
    EOS
  end

  def caveats; <<~EOS
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