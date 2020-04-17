class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.7.2"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "529281db2b4450c1aabdda0e6c53ccfa5709869dae56d248fb62365c0ea03f84"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "9b1434cd60c56aa39d66575b0cc9ea0a16877abf09475f86950d571d547b7a6f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "158d984c679c0099f8e099ca351f30ab190dbf337a8fd30b63e366ce450b4036"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "57a856e0fa199b6c9e80182a1a9c5223d2e1073be6d5a6eaf560cf00db74c6dc"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "dbab7fe86ba5b2a8b4c99ea7055bf8bc681c7804503b844a9ff1061dce53ea12"
    end
  end

  devel do
    version "2.9.0-1.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-1.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "1b0685b03d1dc3f7fa34e434355e64d9975e89e8f80c347684d728af01fed3db"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-1.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "ed753ca872cc764c208293027da93618086b6c9614e52fd4591fb1643de38ba4"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-1.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "5aad1d7e703c419ad87750a890ead7415efd3f094e0fff5fbcc019f5ca5ad614"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-1.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "c4ff295c18d652befc08dfdbebbc7630031fa61d7dd176c666950acb3b6144ae"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-1.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "4ab6fe8d62ffe7533e9c53625d1903283be94fe8088d918b252227d7d1489b10"
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
