class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.9.0-8.2.beta"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-8.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "aea422e0104c65657103e23baa0b6ffdd2883c05e48eccfcf5aab605ffb8c02c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-8.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "ac2a85c4fd4918b580175d259464dd82b7153236e202265d39cba8d9ef845ba1"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-8.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "8cf72dd90b877ea158b449dfb5019628a90fb99f8c1fd20832a3e18852282a00"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-8.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "44ea383d106e067db659d891b86aad1d0a5fac81f11550282f3d67c2ce74ba6d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.9.0-8.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "de253fd1e3a62939debe826d43537b39d5aa17130ddb6e22dc6b0740de16c3c7"
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
