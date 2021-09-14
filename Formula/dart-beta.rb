# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.15.0-82.1.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-82.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "a42bf49c865aff4d91f2eb3756fad755969276d3a3c2dc1c53074ba9b4cf111f"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-82.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "8d1d45f52dd6a055c58fec53f85a0e82169833e6ad92be86c845fd5dabc2bcc6"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-82.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "168f8d95131f1d3b667605eacd481674abc03a48f1893919130937b0ad1b1641"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-82.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "ecc9d2b5fc4e02ef46e3f6dacd1645bfd73a7aee80394b7e3fa0a19b4ca35175"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-82.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e490991aa4ec565a1063dc902127e1243b4065458f27fcd611ff391bf09685b6"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.15.0-82.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "a2da7e8109f2952120b91080afdc5b4b1391b8e598548c7f71ffe6670efcdac0"
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
