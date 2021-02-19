class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.12.0-259.15.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.15.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "ed54af8fcd026abe2c3ede4d91fbc6844cfc2cf719b3d5dd59c436d79f3f4a00"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.15.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "1a1434a869e5ad3772071a4b75ef2c1d830fe1c659e3b9465907e31fe42e308b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.15.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "a55f9a30140d247c8213e3796c398bf67ffb9c9be397f373e45f5e06974f6089"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.15.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "dbe9a0bf465e819452983b50b261094e31ce681a1e401869d07b57899aa95520"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.12.0-259.15.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "07dc9c9d0a505be62784958bb4147295b0c93e1585da40f42dc82dd79a77e1a2"
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
