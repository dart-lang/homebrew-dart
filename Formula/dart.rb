# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.15.0-82.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-82.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "2d465ff37d8d6b3260326073e4b32d0c0a5eea09d34e26a1b655fce4d657d84b"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-82.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "cd8039a9dc1b515810cd4f0cc1019848b0bb553fb947d061b766fe84aee2e38b"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-82.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "56fb35ce1464b3eb4807c1658afaea410a668381600abb4e9cd3ba83ab29a741"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-82.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a79e2ce0491d16ce198207fdc9f82e90d72e8587fee85021aca2e63e13e17550"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-82.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "d37c30406bb3b55045dec480f15bdff748c839bb3f58895751c665ebdf7fd0a2"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-82.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "cd4d464d0cf7bc13c28e3851f9dbd50291220a402e2e06a330b4a207102cbebf"
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
