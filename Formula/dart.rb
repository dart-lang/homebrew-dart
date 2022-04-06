# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.17.0-266.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-266.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "fd7acf9ae03297c732bf3a0442d76cb87bd1ad5d19b223fb86781565a1034278"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-266.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "a05626eaadd26628b960ef99ecebde2f27c84e05bc4101053dfb75bd39d8cc58"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-266.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "c5f9e0e179dcffef957ceb6b5e76f6f41fc3adc2cef4d065c820f26be186bfae"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-266.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "239fdc0e26c1882f359af9938a6ea4e63c9dbfe8f5fbc036f3ed0c9c68ede43e"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-266.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "093993b2672ec644b2563ea9e1de2bef467d55167fd655826743eaf2ffb91c79"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-266.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "c33b51165a12849619fe67cd2f59fb824c0831af026786f9bb152c110c17219b"
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
