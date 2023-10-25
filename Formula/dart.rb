# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.3.0-48.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-48.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "d8124cc7c7833b2b374ba3efb3bc01b7fd980364801726e67ca5d847c83f2e24"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-48.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "3480a733e3f19483c0f453164f3d14a53a7c9ac1be02ac96bf27586b723b856f"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-48.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "ae283eec0aa6e044064a79fc524af3dffec0543c48488538fc1a01a1fae7567b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-48.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "112ada7c0cc7e1af01dde7564d35a47013402fc84d4361a41cde75bde82f9ecb"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-48.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "99153759fe1edbc5c1c6a8c5e5164fad11671eed8a8899bf127a17412b701172"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-48.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "0f67c0b74034702e73e91d8041d3bf42cdca5d6677094c9f78788c9c8ea4ae7a"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "e2d4a5fb3d519b6c9aabd755643a7044f735654834eb1f74c5f0f6f92b7af6a4"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.5/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "68d7096db08e815f5c7fb1fa5f92c6b0b2f570cf52a9446e8c24a556ecb96702"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.5/sdk/dartsdk-linux-x64-release.zip"
      sha256 "4342ba274a4e9f8057079cf9de43b1c7bdb002016ad538313e8ebe942b61bba8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.5/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "0dc218fa4defc38dcbe4806f0d9d4fee9f73a0432f2444ae0bda7828d4eaaab3"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0f0e19c276c99fa3efd6428ea4bef1502f742f2a1f9772959637eec775c10ba0"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "b4f326bd045aae1d4b00a6a74b11d70937fc41291a9d8d62a123dab8bc3ac7d5"
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
