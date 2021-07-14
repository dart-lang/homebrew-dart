# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.14.0-312.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-312.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "714293bb9ffae7539d4aabd0ead28bd08a28148d65c3547567709c0d5d1b311a"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-312.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "7ced62a223c27b667e90d427546723696ce4917bd3736e46b5abe1289ce40fb3"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-312.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "6d7848de6b828950921b2bab3f4cae725cfbf0528843484864f536eef9880e0a"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-312.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "8ce5180dfe8f7c66a0e8f837340a31dd6920ee66dd91a6702339bc7c765bc78f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-312.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "4cfe653ec20854271e12804060e42705d88e8a34a53fc97f0d4351d961f1d7fb"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "934e3951d399aa654f45851dfdf6614acc34a20aafd8631075194c02d58e0e4b"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "633a9aa4812b725ff587e2bbf16cd5839224cfe05dcd536e1a74804e80fdb4cd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "3116ac10532ec954d0dd31b99cb562279109909ba818dbe081b1c2059a8f50b8"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "4c6c2dad0cf2f61e5512660937d99c0c5c9d1a51e8f0ae3cea1307092c9cafb1"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f7733f30e44345237a817bf9104fee1e20820a5796162770b964adcaf705711d"
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
