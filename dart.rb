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
    version "2.10.0-2.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-2.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "85870aaa96345841f4f5eb292108e4e61e2bd7f5442bfeac9196eddca8895d64"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-2.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "d06179bb3b06efc403c5bc6a70d0700e7baddd3b24639836631fd6dc31990b13"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-2.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "f592d6775c27ed5ff4c725c2352097a60d12dbe1bfaa6924a1c5f217283fa71d"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-2.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "92dba168103c8d3e3814694cacf48ceab15f367945aaa077fbcf59188ef85c6e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-2.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "b02b21dc648bfa1fc6f814b55d77e06f3779f1397e37393f2969909707c7e5c9"
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
