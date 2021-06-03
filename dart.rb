# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "Dart SDK"
  homepage "https://dart.dev"

  version "2.13.1"
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
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "caff3814a7653b5c733a13392215469cbf357d756778ff36d4a0955bb3c8664d"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "384b936b2033f9d57b94b2fae86202ba362bc5df811b5d98e401f0ec9fe5087f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "72d2e31ae61373ad2596dbbf5a2a201ae27268b410fafba3510844b13bc2647f"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "ec652347a2fc50fdb6a49576eddf5689c7e647b82be258ab44c0dcf26a93692d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2270c67049df393cb9a43ad15d37fd0df7d7e80540233b3f922ce4f0cde30d33"
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
