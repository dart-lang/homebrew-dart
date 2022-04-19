# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.18.0-29.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-29.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "c9fa3fb3f2f15aeb5f7955f510986daca1aae353c6c4a86dfa80f1c4453f502c"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-29.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "96016c4df316af2a3508bfdf3e59f9031441250e59dc0f571c066b78716024c8"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-29.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "619f42f8ab08826ffb7ebdaa2f91d47360bd54fa03865994320674540a3a94c3"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-29.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "307bf91a2e95954db04285a27ea26664f071f9d7d24a534d1036def616c18370"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-29.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "6dc38ab557a380f2c009fb30db50dc26cc233ab77f65cec92ce85e5af76725a1"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-29.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "9d94a19418af101901f873e41c447901abd3fe3de017caa1525f88895755bdc0"
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
