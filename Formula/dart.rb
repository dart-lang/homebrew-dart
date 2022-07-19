# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-5.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-5.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "ac77425c8c421cb95a0ef93065e8b51d0c4b11a47bcbe66347f8e30fe72b7269"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-5.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "fdea5e3389280e92d534bf249f795bb0a5073765db886ef58a17f90ef850415c"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-5.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "d2ee3675809b924c09ec7a0fcba34a9302aae1b813c898f812fea19c2c795db9"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-5.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "4518efabaef04806e89bc157cccf85ab2c3ab2a6fcd648455e1787d94300f1c3"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-5.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "fed85ad107f63633256a16c1eeb73d07315a0dc879692e45fa62449bbfdb15b5"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-5.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "c8425434fcdc7802a4405cfe93af4f4eed61010aa55ee43235760a9933c4b6a2"
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
