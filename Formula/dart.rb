# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.3.0-120.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-120.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "0459857597a72e2cca5890180acc7d6f339ab899ade042cb67a0c458fb46edb9"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-120.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "69d179a9ddd067c820b498afd3d1510f37a55fc6e5b02a560354a30284de8546"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-120.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "5509ebae275a05813365a66bf7bd24c8bc6c1221b9dec7f2eb5919c5906b1f60"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-120.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "55856d2a6f7e6eb9538d156e85cdac418136402ea8219cd79ef73c20925882c5"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-120.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "f048a5e06eb84ca9d9f01a5e282cad72e1734603b0ee1a94aa2e8a546a16c663"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-120.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "7b28e30653c0d580261debd3d8a010bda702da2a9452d210a12e2902d60516b2"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "e2d4a5fb3d519b6c9aabd755643a7044f735654834eb1f74c5f0f6f92b7af6a4"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.5/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "68d7096db08e815f5c7fb1fa5f92c6b0b2f570cf52a9446e8c24a556ecb96702"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.5/sdk/dartsdk-linux-x64-release.zip"
      sha256 "4342ba274a4e9f8057079cf9de43b1c7bdb002016ad538313e8ebe942b61bba8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.5/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "0dc218fa4defc38dcbe4806f0d9d4fee9f73a0432f2444ae0bda7828d4eaaab3"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0f0e19c276c99fa3efd6428ea4bef1502f742f2a1f9772959637eec775c10ba0"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "b4f326bd045aae1d4b00a6a74b11d70937fc41291a9d8d62a123dab8bc3ac7d5"
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
