# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.1.0"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-174.3.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "72e91e3a56b8fca78f92056f7b88982d6e2c3a27a1812eda0bc5b70027c8e00f"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-174.3.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "6dcff8e1b6f3828250e4e58697c1ec534dfd3a2199635f988dbd1365d9919fc6"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-174.3.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "24fee21a8e378050b0b0611602f674059d5a93bb09a560539857e384f1b83056"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-174.3.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "8a6aabc9dd33e7d02d91e5ec001a11241617464dc9a895152690206e840a8be6"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-174.3.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f86de4ab4f99a2dbdc6a0809acaae40a280fa3cbac340bbdf910cf7f0085dcbb"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-174.3.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2cccf79d89105294c46881f0f7d7e1f574d6cb2d8a12de7d0a04311dcde6acb2"
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
