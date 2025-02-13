# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.8.0-91.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-91.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "4850c47c9018ed0d5849a35a3bd39e37e3c2eb3f5b671955e87b1188b835a60e"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-91.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "cde943030ab6dc49c5e8a29fb3352e3477852fd52375569fffc60ea2d6491419"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-91.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "5bb9043d8f2a4f27cfc368188a9b180587340382e235f6be60b97c23de53e459"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-91.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "cd12a784dbec42b27d9855ee79e17b9d7d616471e65fe1de14dcebd767d608e6"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-91.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "55c01f6724f3e0e553c93be9cb1981b0349c1138f6049684735384fc60cc5aa1"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-91.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "343bdd0d6d1354f39e3967c87246a9b236b53aec1b1193574ed1dc6a192cdd46"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "d601c9da420552dc6deba1992d07aad9637b970077d58c5cda895baebc83d7f5"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "9bfd7c74ebc5f30b5832dfcf4f47e5a3260f2e9b98743506c67ad02b3b6964bb"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "367b5a6f1364a1697dc597775e5cd7333c332363902683a0970158cbb978b80d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "d6998083720f01825b7d75bece26cc11e467edb3e8b3b46d02dfc1e01b06d52e"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "7c849abc0d06a130d26d71490d5f2b4b2fe1ca477b1a9cee6b6d870e6f9d626f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "03842c2037f99450a1433f5dab9dc1820686eadf92f517929d0306cbbe92ecd2"
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
