class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.11.0-213.5.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.11.0-213.5.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "ac424d362b27c7583a509064f4d241368c5e42202a8a42285f469e1c065645ef"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.11.0-213.5.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "859b2ec55b1804cc32e4e6c3d6de709e38983b76cf4a490ef08329c582048075"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.11.0-213.5.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "38b4ff7f2d8a3ba1ed3dc0d92a2ac670991f33b76c203a32f71226196dfc1254"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.11.0-213.5.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "6c9a7ac84cba54d07f51884cf44837ab11f67117601a8944f8afddc9fe0d0875"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.11.0-213.5.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "6dec65f171710e58f69e0663e3b1f4d288721003761c15fd16ef9fee0b9e33ba"
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
