class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.8.0-20.11.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.8.0-20.11.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "d575dee1666cf976395fcb16dd16d7ebe6f5fe39aced7dc6914f95407b18e1d1"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.8.0-20.11.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "fcee18aa3fb7fe92dc677db80e79cf8398afca71bd8b3dc71da1c9b7f1cb62d5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.8.0-20.11.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "69afd388b56dadc38c795937654849cee069c4051dc789af6800c12170196bc4"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.8.0-20.11.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "fa09e065b74c73ce3a620030c68623b5c04e74b08323dc81381a0668a1f4c9b5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.8.0-20.11.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "9d79bc9abec2b379cb7cdc3723b79c283f0ba42d4796956a2b507e3167841294"
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
