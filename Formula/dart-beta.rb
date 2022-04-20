# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.17.0-266.5.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.5.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "02ddb26b18abd125998ff221ef169ec8896d7b052315cddf39a45c7540ef25d9"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.5.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "40fd66523cde6f6407c193def3703556e911fee0c9a9e783acc74003cd5f8ac7"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.5.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "dc3123d87c1b6b43087520ba9fa7e6fd91f3c4652178d55ca41825f4fc7100fe"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.5.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "c12d95f0e8145e9cc91672fca0720de5ea7a518885236b0ba21d14c2b30dd80c"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.5.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f6c0f0777241fb8b2d0607295f794956b9a91d3251f639c32fd351902dfae931"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.5.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "3b825fa4c6bdd7809185d9acbe4e7030900ea0edd14c17aa6255d7665910e9a1"
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
