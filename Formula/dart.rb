# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.15.0-101.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-101.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "a0f0988db376d102db6c9cf2023a30a285a308f754907fd1cea75a78eb9e635d"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-101.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "9f6b2a4137c0f0f5b0b0d85a7918623592978ff0c0e2b50edeb86bba7bf2c523"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-101.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "9161474205ab97a09aa82f3d91fe38b3423b140c2038a5cfdb870e7d1242ce2f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-101.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "bb385af870ac12fc26042a941c701d4de10a340b1de8ef84d878511e2654c3d1"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-101.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e8d2404b0a024852243ba7c75cd35232f7fde41176ffceab5af34688103dd43b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-101.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "34a6db67bf3af2298613a05e3f9c6c05c83d93f7f744f0c89c60df04e141ba9e"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "d0c24bcbda37950ae37e4e7e7cdf93f098cfea8ada39fd7ee6e06c7d97ced704"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c9e7ec9be908b2f8352730d9475853d008176fc9c00b3484a65033c739c36c61"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "bd352ab4df3de74f837dcc95f86917d925d71793c4b26c2650e0cf814c6e22bf"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "302cba4dea5f772caca6c61be78657a1122a427908d4db04c960b4f004ddb5ad"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e1e5514fc31457b5743781d72054398492d19a37163ace2ac3913b82017f4acc"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "09f57f277608e52086bd290775ea5991c6eefdbe54e6dc491550fd9ddb7c72f2"
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
