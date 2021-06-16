# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "Dart SDK"
  homepage "https://dart.dev"

  version "2.13.3"
  head do
    version "2.14.0-216.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-216.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "872528f0c90dccf94e69e692a86dd1f097621efbc17533fabcb6c11af9f4090d"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-216.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "99fcdfcdca45936eab81c401cebcd53cfcfb7552091add9929acb29b962a5d20"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-216.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "c4a794bad922600da1193f4f5629dd91e3a69dc1ebf884ef8f19b9d7d5055446"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-216.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "29b4ce1668d7a49b5328a4a97215dc6e4aa6c6e0edb725cfcfb98267a1d87c38"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-216.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "f0aa26c98b5acab5babfc4a3b14cf055f74d23db7586d713ef04961c40b3bb8b"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f5ebc9da1554b2901ae8fe46f83db3215acd4579f396d521f506740bde7eb73c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "b33ef6cc021e88345acd06333ddbbb5771130f4d23fdb6eb79dce7c31b78071c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "5b7f86633c9dc43893a179f8f6c42a74148d348269b0b3e0b40bde05fbd41be3"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f48adedbf471981b140d37126be0e54af4a167baebdc9e5241656582a930a4d5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f5a7dd1598eebd5f0fd20704adf6acc3cd23de1f2b93b6b59a657dd524e14b17"
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
