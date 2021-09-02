# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.15.0-65.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-65.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "9c71429a806dd2ac7968542771764dd5d1b7c71fd03851c6870eb5c3f687fb1b"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-65.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "754521d866bf2e878d2b4a33be96ece27a6381aa4b73a397d0b349bdd87b4eaa"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-65.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "af6537fe9b248f704420e05a88eedb0b2b0db9c8f3e996da90aabd2037543286"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-65.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a19f58988af2098a8f7ae4996fa25f95a86d43188fd0a796cc3740a5eeb2a855"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-65.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e9f3bc610cea89c972a85767d86ab424cce6cab46e3da4065cfdd1aadfc43bef"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-65.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "71da750dd2e78970b69c3b2cb388527d7a1ccd70ea8e8cacb5bba191841effa0"
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
