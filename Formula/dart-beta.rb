# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.1.0-163.1.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-163.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "58ff6fcbf11644bf1a57581c9e9f185baab6986ee464a448dfc1eabd7d4451d0"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-163.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "5b7c26dc5211d8798fbe2122434c096383803c5fddaa47becc883bf235cafe41"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-163.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "b4d251e51da2b963eae82136b37b83a050f175be82fc8d691b609cb8e030c13b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-163.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "ff53aec90c5d4055c5972c5f51f7f2a3ed430dd2a5d223525afd8df44264e70a"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-163.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "8c65c833fe84010670066450a404e81a9ee311b14cf560e8d6325fc9a351f8b4"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-163.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "32dddc5047f58a3d2b53b0f238aeaf9d951fc7d91559b024fd0e1ca3e0afeaf0"
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
