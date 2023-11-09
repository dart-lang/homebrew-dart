# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.3.0-107.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-107.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "eb5beb287cfb9a37c7f513cb4c6973b4119dc50f568ba941cbeee4421b61b1be"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-107.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "fd996596e541d42fe72f488bd08dfe4a97670ee5bd29543b46f7467904ed718a"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-107.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "a2244f1e52206a26221c643cd7fc6f85a153741d70f8fe8a709ebe1d852d231f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-107.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "d9440f6d48c7d2e00b63f51e521285225a931be456270585c0d55caf43557576"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-107.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e78fbb136a7b25f462a9d77fa458dc989da0cbefb18af1a0f2e1123e84564441"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-107.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "c6cc02c1482702258250c35bb91b744cb0dbd89b3eb7066c24ebabbadcd83fdd"
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
