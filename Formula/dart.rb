# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-120.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-120.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "7573288a3e365cef54fc96f54b66fe11299dde433008170d9b0409dcf1c449a0"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-120.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "81894bf9d37789cd334bc45821975207f11e1ac8910160a441be2c16ef730cf0"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-120.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "17bd5d710cf3347b63ada084d2097b990de70f7db82e3ff82707dfb498fde2b9"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-120.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "63751a508045d852e245e190298fa96d6531ab8c06200487179806d89fb2245c"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-120.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "babb7a240df80c543ab8b4aa5117508468632450e4f4d87c484cdf599468352a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-120.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "83e50afb60f0769c0b8d64802f711611db978f3538cb839d84af87664e5e4540"
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
