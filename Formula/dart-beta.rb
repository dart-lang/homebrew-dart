# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.0.0-417.3.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.3.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "6bde59a0ae26a5e073b3595ed012d90e21c7cf29d732d06131eaea88a8b745e2"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.3.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "f2ec3d6c6ed2487e0f45e89620f35b2fbe73ceb7308558336dc764b5f29ac02f"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.3.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "2e6a37be49866fa023eb631938816660823ccfe5682360eb565d4d0f1db0acf8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.3.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "7d7af101124f838ebdc4038a2f73cbb6283b1477aafb15609403e29d318aa9c0"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.3.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "1efe073a207f5daa0f4e5ba129c6ada0c535c3dfe6a50c7c691481889b98b8af"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.3.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "737c986c97f4cdd95e6d217215ae5dfa6fe1eb84f8355552d373150a1e791718"
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
