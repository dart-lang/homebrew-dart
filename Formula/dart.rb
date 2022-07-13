# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.18.0-271.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-271.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "e6037110460a6f782d929f0ab980256a56d934d223d3bf67dca19175e855dc51"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-271.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "1c0f95826c6b50d60e6717b4c553d277cbc9904fa352edee591bd4929862d025"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-271.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "d507faf120db2b4949e750800d38b39a088df98319c095cfb7e7351431d3cb92"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-271.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "0b5fc8801c6dc7e562b1e815603f9dff4754561f621984f7177e2920a611deeb"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-271.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "cdfbf3bdffde243951ae6ba7b431df0e4a5a5c0496dcc34343534de14949b444"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-271.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "9c97a0fc1b5a2b769fc7ee3abd6dba9e8ddc68fd265e0a77ae53f818513ef262"
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
