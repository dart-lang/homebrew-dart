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
    version "2.9.0-3.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-3.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "6f2f89c556e995bf5364bd9de59420db7f23486eaaee503dc830b446517f8452"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-3.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "450d79f2a49a58ce4251ef1e9ca5daafb35981daa8f1f00963fcdf01b855752b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-3.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "37b3348db3fde14ebb246052c32c5c87654bdc1e4521f7fe7647c6e5449431a2"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-3.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "face97a8e24910c296250ed6629617d1ad2dc0a06b6bb9e58740d4bf048f63f9"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-3.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "2d142eaaa40740c2d4d7a4f1afdba070e9a6b84a442ff8c89b4c66b78362c4e8"
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
