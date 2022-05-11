# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.18.0-99.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-99.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "6964783bc60e4225756c6c48dbaf59c7b7eab4bfaf399725d630dfcfd4b05c90"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-99.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "e67c46662c01e07918bd7fdf19194a938efb6e31b88c63cbe1cb0357b536dbd7"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-99.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "b6899ae1dea1204c4c643313c01d64b785af750bfefee8e616cdba7810fbafbd"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-99.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "4f2500fc271eaf35208c381da594c112338f2acd597e7d0b852caa277773a058"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-99.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e505140a5ff57d3a859cccb2682dd430eff2e008673fda42519525a23b9f8531"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-99.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "f148970170657ff709b7d14d8b6ffd7fed272e6dafc65cc6b9434b09f89bcc6f"
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
