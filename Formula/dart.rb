# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.16.0-40.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-40.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "2573f72238e64fed6e97e92d6db4320843613d0adb3359031c263f99dc745a18"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-40.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "8b273e5e6a2daadf303a332bb1da4c294616b2059a489aa89476d18737d59ad2"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-40.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "3686e2d90151cc5408462d1d4ebdfb3a6680bd396e9a45388d36d96147d6b74d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-40.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "c2bd0b3772f2de42278944b7ca5d7e6d54757106e85e9d9d1589015907871726"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-40.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "3b39039d93cf46f60fee10b4181c11b2c71daa9ffabfe44fad13a017744aed8f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-40.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "0d12e5148f75530f33f2a28aa5e315969942ac1a5203ec178485e6558c61f4c1"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c900f6ccb62e2f7526f457d00be8fc296e7c2ce9c7653cf007b5a4db7fe9a9ae"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "3abaf0c2d57e05c27c873aaa47b7d88e59c39d5fc78ae9894dfb880fa18945ea"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "49b6a98008ef546cb9c221461529d6c02cf2474bff098e0dc7e4ff1ef0f8a289"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "f6b73006af2e3bd1394877f2e539ef88ae6a93968a56d4124e3b0b5d68b4de36"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0477fae6fcff58fec18d912537f13d647fa0e137fce23401eea73102dce62351"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "796b64022615ea75f05f20a3d5e7018e52a1d26c06acb1d2b0b2faa5df491a64"
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
