# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "Dart SDK"
  homepage "https://dart.dev"

  version "2.13.3"
  head do
    version "2.14.0-176.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-176.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "6c0d1e1bc046da9c9d47bdeba1e2c6a154f6e7caa1eb2d78c4fbcb1e58fbfeb9"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-176.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "d2adbfae4566efe16a1445c41f0fd7df8841fe9bda440324464025a26576aa5f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-176.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "789a43581bd49b7c85d0c478765cfe2e735e562f3b18ce323612de0370d695b0"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-176.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "a14118b123e6114aad6278a12e0a2f38427ad740554458cd9653820b109ae6aa"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-176.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "bf7997e3a028c1cc3830a41b44fe0f05cdca87ad531f0409f1b3dfa426ec1c07"
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
