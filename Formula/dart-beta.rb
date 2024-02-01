# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.1.0"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-279.3.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f6f94dcb886b364e819f1e6a0630143bc4503ded9afcea7408a4e5cd61f01a0e"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-279.3.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "ea6e4b7dee089ce6d8822a663876a945de1f55707c719fa5b4fc3e643c5c450f"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-279.3.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "d127a5e958e98d325fa9273b45ea495e0108cf0e7c7bb9de52991b5c79c0d6be"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-279.3.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "49fa23b1c0f60aa9f50eb9c47f0d736d4730c19d51ad9747555d002cc1dc84f5"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-279.3.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "48034e698fb1bf3370d70e437321e6ea96762dba9ce5f0f468b4751edf7f9012"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-279.3.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "e141acb0d793c217ea71807f8a0e3c39d9bc7811b413e8b9c7bc0f8816a1754c"
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
