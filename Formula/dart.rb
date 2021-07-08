# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.14.0-289.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-289.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "c49b07af57a39822a1652ee6781e55e8e9017402621a5f29f95b6bd74b22cd81"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-289.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "409ae8e03c4fe49930a01646ec17775e14375b99e5ba7ef88b0817d42578efae"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-289.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "3da034f1e4c43281c079e3f840bf14fa6440ee2c77da649d526b43cf74695cf5"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-289.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "1bc3ee032dc2f1be10a6bb76d53425844430984bdb7211b4d2817d696ed8554b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-289.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "58ce3b22e5b8d68afd6ea3abcd1e0f7237ccf7b549adc4611c5cdcca84c302fe"
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
