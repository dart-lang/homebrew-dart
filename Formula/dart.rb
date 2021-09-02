# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.15.0-68.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-68.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "e9dc3d51ff60d36f58d9116b6333e18f7b801329871113d6a029af4be2a95688"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-68.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "e6c41a807897989f2600f2fe60bd75d593de4b1c5148929d1fce84c6eb6d8317"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-68.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "bb3afc72c035b3cf59d7dfd981c6ea4bfdcb0600dbf4d57763c96374e28e5b7c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-68.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "ebaaf16e4bbcd90d1f5efbdc574bab9782bd0c7896dbafd2ff0b295b0ca8197e"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-68.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e3d7f17e9645aabb1c2a3dfdabca6e7885da6a31811b37acf108262b2d9411d1"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-68.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "609edb6c012f4262df2d6bd704c8c71e33ce6d3f5f58d885dfd070d0db15d989"
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
