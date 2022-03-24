# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.17.0-222.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-222.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "ce98866c4c827e7adf0d40db2e374e7de6fbd4b57625db7faf908407ff914048"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-222.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "2deedd47e28d21a93ee96279ffa39c46c229cfadb11bbb5a17c6f4a43011f075"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-222.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "3f6d9614ba0a92fa13f65c75aef2d0c16ccf51868a6ab8846cd259c5774c7cf9"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-222.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "c7558d2a4d0373b397e39989467474dee3aed190042f3a7e799c07075a1dd285"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-222.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "970a65c27b3260c7ffa169e6f7cf203c0699042cce699a785c74eeda0c2a3fc5"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-222.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "88084d26e872d8be58ad43b037e07daa3967f3c77257df1204844c8f5384a9e9"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "018bc1a063dccd5a1f7c86bf06ce4660aad6a7dc441c10d8271eab1afa48746d"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "7994346806962c2ad2a124f4b2cb976a0260c33f2df2599ddcdc576b9aa3a20e"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "7a0ad877b0785e19018873c8144db3a29c4ab50e7c1aa968800280fd47a25e72"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "069e554c30a9e5023a00a4bb2ff5eb2ad9d3509c3e6363ea39db2e4d00465ca2"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "be67ab8d79140149c8f058cafbadaa2ea8044e603e04b3c4657171c18a48f8a6"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "6eb58d7721bb27827d2bbb0830f3479c0e1d4c257b1c4c802ab8811c7938b02f"
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
