# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.3.0-214.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-214.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "29bf4e0caa1834ffc8eaf74d1b7249194ab3f02e3944142bdba60db3eaa7b1db"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-214.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "035d25fa52f2ee2975e280a2d09bbe2a3f7acd531ac91dca06566d6e69815335"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-214.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "e60a993dac5c4f01d6069d664a041bad85aaa83d6a07617191a4fe216d86ccac"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-214.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "b0bda23d8d29f9e106d87e481ec04b0f85fe1fdee8d806b4b08430674cf09f62"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-214.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "53a86edef253e690a72a365a9564a9f08571804d999b06e177a3b04a2476c659"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-214.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "adebb991a1b416570b0075f940bb4b10d28246b707b960625b8e42fd2647660b"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "716239fe2fc0237e5a31446ab5e3c95a8550a6bd7d5c5ad404c2dacd3aa4953f"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "a35017cf51e1e2b86801fd9e0937d7690559f096631b57134527f51f2d6708ea"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3a1903a8743422e13e93fb3f497c179fab5658ae32b9151a7baee3158461e0a5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "a6c19ad36fe3a58934130bca0e0801c9addc692aa2815b4bd9dda556c38859a1"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "dcf3c8116070c77f2376cbbd5229712a4e6874ef66438c0611e2ef23f69b2862"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2bb8a9faf7de11294c6c0f327cb7c328357f8872a5112e7d3abe6d35bc5d8199"
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
