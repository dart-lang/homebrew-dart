class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.8.0-dev.20.7"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.8.0-dev.20.7/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c2abf15db84ad567ff99ed25afe31d2360c6cde69d6fbf0ae17662095950d1dc"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.8.0-dev.20.7/sdk/dartsdk-linux-x64-release.zip"
      sha256 "20bdfa62e0b9d1db4813d1e81fb33ed497db519b4dc1150c610320709144a3c2"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.8.0-dev.20.7/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "cce6ecba93d1405c3c5173bc7264a14193614e3e1802d12da3804395e72a2be7"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.8.0-dev.20.7/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "fd5e4cb6d3423463cfecec7b33e9bb2e4ff8ad0c0c4c98621f8d84512224cabc"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.8.0-dev.20.7/sdk/dartsdk-linux-arm-release.zip"
      sha256 "a253e908c4f67cf3a61eb0a9806f6a858232adc52a044554eab2c724b24f55a9"
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
