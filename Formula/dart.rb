# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.14.0-281.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-281.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "a2bc4228d52858d8c3ccc7248a0a43838f03d58c973518f34244cd9d8daedc5f"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-281.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "47f1072efa9606a6ca5379b2b4f02c60b4be389a66ea96477c7273ee3a8a3c0a"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-281.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "f706941ae6296884cdbd22eaa5078673fed3dec63c51fb2b576e685200e3c8f9"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-281.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "365deb96ba3bc97d11501ac59c0b1f20bb996db06cad26a1c21a3ee5d15f7a11"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-281.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "0bc2135b3689aabbf7185dd410e8ffc6775121f88c88d029ba3ffd336602801b"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "15aaffcc5c6aebcf5e907f721671a9f03cdc5e0b95affa59a9d8291fb2972421"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.5/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "9dfe7d6f2558816c2a978aff6c80e8a4509c6cb726c0702a616c64d286f60e88"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.5/sdk/dartsdk-linux-x64-release.zip"
    sha256 "ea864bc64df30a6b8bdf30b2e32550f7717d9a890de8f40293aeabb924fe232b"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "19a731647c3ed55058ee46dde00330150e6a8729bb6121b4a31e86084c8a3e6d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2c33146273ebc79e46bc06c9d46eaf1c9e36e25a361bd919259b89d231889f91"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"].select { |f| File.executable?(f) }
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
