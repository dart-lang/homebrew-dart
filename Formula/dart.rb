# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.4.0-260.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-260.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "f25c827683e7f80021ae6c502cf08efd9532864e53fe07eca0a4bf827584b31b"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-260.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "2fd8e18400b539c6f0bb8f786d728771555028f9a4a125abffb08e553ac9b51e"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-260.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "d3f995e86c9c873f20e9da64f597dc1fe294ac00dc4c63f3bc220df442ef07e9"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-260.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "82edb8e51103867134a4b306958145385854825fb0acacd0ddc7c932b1f08b1f"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-260.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "f27ba9cb820f38fc6a6618ee7c43e43db10884e054c5b29f85be90e9dcaffa8b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-260.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "61b587ae6d39b1530d823a168806450032e1a957bb652d82828a119deac9813c"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "537146873435b3f0d2a39cea421c958433526cedd3ab81afed7317e91c492446"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c7d79bfff7f8c929b50e5160af1cc4d5a0ea70f77765027086679cceebe2d839"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "2025a47313408d1b1be943b0ce4ca3d5b629f2a4b2a6cd8ea8c6a323f1693d1e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "16baf24de9e47858152b8a07e2d286ad5298b0d4902c9a8f23318accba8f92cb"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "a26b4f98e7b7fb6feb8abe4864ab5c890434b0a048220e27f1886b7435c1321d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "6a394b1206a73001193befa7aecbfb6bc8c8d154ed4d3018ea9fc9c4c321ea4d"
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
