# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.5.0-323.2.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-323.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "eeb5d51c6b3dcf0dab557dd9c8f01cc018fea93cd95aacca16dc99350550f8ff"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-323.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "16ba2cb697c3e5eaa5c11b65498cd6c26e977004ec2656f38909e8246665a369"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-323.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "f23493fb3c61baed047e6e162e09755aa16c9bfa604209c7d16cfc92a91e4191"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-323.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "3f7f03e3017e8606de36157c2911e2212b4bbf3b7db8d02084472df46bff4d05"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-323.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "d26b0fa2df29628043edab580fa0836adfa37e913d32a659f9b5eeb2b79ffc86"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-323.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "de61040069c280cfdd2b0a4ae71d548bfa2a9c25394935c78c501dc27c316d20"
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
