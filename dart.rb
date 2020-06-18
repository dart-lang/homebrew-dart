class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.8.4"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "0f576e249e22f61301d46a5bde267f08a330a1ad0954be348a10e44e43bdd94c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "39a6b937fc69e9c00e0ef1d1b3931bb0d63d49acbc3efbcc6114352fb301d5e3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "7d113061130945cf55aff23081aa44957197178842fc6be1072e12b5f78450e3"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "8cfbecaa5a108a951ce9f3c0c9be045001c1313372f6533d1a8245a32ae9cf20"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "04e6e315532a27f1e295dfb67176da680baaeccfa41beadf4a013334a9e7d557"
    end
  end

  head do
    version "2.9.0-17.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-17.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "6fec8a02bd8b3f1cd4c8d0fc3443e4913e9f4f07dd6c7a1f52db0c73f3bbcee0"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-17.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "71b2a6abae03995d81488ec9f832f0e12e8df21ef8f2bac4cfd777275f5cee4f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-17.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "c364afc5a5a93bfa9c7fde69d92c6a9817f2e23822c631a6b4ca60b785c3b919"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-17.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "3f8f04b584bf89323579a7cec55a0d2d6e24cce70307f134d045d9f324632088"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.9.0-17.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "2a3fcc983cd2c6e0ad43e208af9122ef5e35837337f61285925a0460be88fc8b"
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
