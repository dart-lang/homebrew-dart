class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.9.0-14.1.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-14.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "8ffdb55defdc97ff3ffdae5419abce4b10db323d31a47523801b9b25ff01ecae"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-14.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "b54893f0c68d44c9e8823afd06273691ee00b3ea83991d4da76e5841ed352ab7"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-14.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "e0be8e51fc4394314bb3a01dbf3f42d6c9b76eec2221e68f6f0e05d68e68bd2c"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-14.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0943b8809c5295773815f600d4f5fc873e083496d6f3047032ed373e949cbdb4"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-14.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "acbe9de9eae4b6938e829e9e5722b6901ed40f2f002b55e0fa0a5207b96dd4f7"
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
