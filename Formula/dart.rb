# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.14.0-336.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-336.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "6a5fa547e51d1d5e25c91259711bf85375aa5d68b79a3a177d2771c1dbf9ffe7"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-336.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "3f4c370bff4da5f6303014899bfbf9115fe1661d47110f83d26434c34401211f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-336.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "4edc0cab81ca985a3d0281fe007279f9264fe8049286ce9fd0dfe117ec06543a"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-336.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "591a522ec6a0b311782e4964e9f12bfd7aa201f68aa37c5892596fb41d056fea"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-336.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "52420c15874b7b1ef6f82f3db29c4d607fbdddd8704fd39caab1d217e6d7e00a"
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
