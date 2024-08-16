# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.5.1" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "4c4664d675f69440b6e5bcbae80868817dcf657360ed233a78638060721b67a3"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "1083b8fc5dbd9db3d3801de5ee05bd53eab6036acd1572d5ee60e93d29b75aee"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "ec7cf3dab7b7b19f42bc5bbdde9f04911260ca828604e877862046ae10afc27e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "fc4a0d4970b6b91a0a8ab76c52e09e54393aaa9b0b53113db21e86e2a2f7a787"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "1bb01530d5caa7d623f3ea30307aa129d84e8fca9d63b36240ed8c3bfcdc9653"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "bb3633bc6a32cf676b9824421bbb1639c05c821dc3fde9727f62ba9eaf349ffe"
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
