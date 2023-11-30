# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.1.0"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-91.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "e1c83bd273f6e6d212e26deb4a7ecc8a06ff19e854a3679990c6a4d8d0f65cd3"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-91.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "d4c175b50650b0cf7cfc407e95854a0febd0f4210f611d2e1b5591c3d6dba5a0"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-91.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "c5754545391bc9ff5bbfb3dd2ea573f0297821162d39e23eb9f58fc4445abe39"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-91.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "8aff211f8779b40714c3a9c043b76c067cd8c629a3a404748b64188940d658cb"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-91.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "cbcbf25a8216d59b4f3f97b9d80e78e553453bdcc3e8e71812369449a6ec12a1"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-91.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "b8eb26cc12ea67de238b02d62517dc28a5b297262a14fc20a57ab1bfad60bbba"
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
