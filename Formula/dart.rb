# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.15.0-116.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-116.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "f8092078a9387c29df51d934ebb9fe995f55f28b82a984036aa0d98bc03cdf02"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-116.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "790ccb585dc12cefc7d897fe83ae3f4d7dc60be72fa8764763f98ca34732f271"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-116.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "f06542a21925945e32e102a1c02aeabed6c822485c51ac3c712f212eab727ae8"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-116.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "5fc01bac2e34d0c65e8cd42c3336d251a8df4b049d1ca71e9656279ece224a88"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-116.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "a4732f5bbadca88c0cf112bd67cb52ba82bfbb13e8d4aec4dc0b9a1978b20157"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-116.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "093bf02eec834b186f63f4babd2751b26aa1588b4e7f30838663df2709aed7f7"
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
