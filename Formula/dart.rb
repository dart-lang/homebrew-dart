# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-32.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-32.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "b343e66ffa9d1638cf6d06614fd472253440d81318b0e89a110417e8a0ae1d3b"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-32.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "e8ce502fa7428f1a28f7f882db63f77bfb9124b754ad3e1f68921f0d34b86491"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-32.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "71ec0a55119b70beda3f70e26dfc131484b3289670c16cc330d5538cec1ff518"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-32.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "ff5ac33eaa3ff8e3b1b3ba72974351195f5d2d3d36c9bd74029d8427d8c1e176"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-32.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "531e36a8a0c97a3838c13606bcd8a51c0e681567bfccab5e1a6d59b9aeecdf47"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-32.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "eeb2760c3a78a7fe393d99ae2abeb43b633b22a36821528dc1153ba70143890b"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.6/sdk/dartsdk-macos-x64-release.zip"
    sha256 "9b1881c4167bba76c6ac0f92bbdb777a9d2b89c62977a7e95c37e028ecb9fa62"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.6/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "9c655ab17e1239dcd3ba56d8a9483ee298dc92eea305a46a10b2fccfc7e441f2"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.6/sdk/dartsdk-linux-x64-release.zip"
      sha256 "f837f385603a1cfb14ddb7dd0cd64820b297646626bdb689ccfc3278fa83b2b1"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.6/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "339133593726375213fca6156288fbdcb4c0644d725f8531910449edca2315fa"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.6/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "8e71b0c958a587c83ecd6c8cc637bc624bb85bc64e877e9ea00831a659a904b1"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.6/sdk/dartsdk-linux-arm-release.zip"
      sha256 "3eae7ed5773c125165d123a235bac9956981cfdf164059806ed69a6feefc1eda"
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
