# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Dart Beta SDK"
  homepage "https://dart.dev"

  version "2.13.0-211.14.beta"
  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-211.14.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "8bfb56fb3f4e91a79e6e1a0ddcbdf981ba29d87acb0a6d2f70240535245b4132"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-211.14.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "d33e7727eb3e49fda8c854a4aa894e642b1b760e0bf68ca382778f30242904c2"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-211.14.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "d627bd36f54b32c6ae775430a712fc5a410d44ae246051530972034379417486"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-211.14.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "dbe30e7a8cd764b5225ba8a385653f4d2a754e92369f417a24f33362c9afa86b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.13.0-211.14.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "7a6f2af3bbf665d5c214de97d809884424ad882eca97a41a4a01d314f8f9e478"
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
