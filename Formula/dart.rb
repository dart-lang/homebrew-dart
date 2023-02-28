# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-277.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-277.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "01184d443f42ded720c8abd9830f4ff340b6c91b7fcd5cd1c85018fa369502bb"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-277.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "7bfbeb800d4cfaa990ded9dd42ac1a16157d98f12dae5ef3868b98a059ab1c1d"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-277.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "f2ed05b9c72172fa1c562f054fb1f4dd3fd1dfce7e0b4d92879c62656bfb96ee"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-277.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "3b8497a8eb60c3da9bce26396fa3aea9f998fb352bb5b10139b555f3838d438c"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-277.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "b8fbdbdf2a1de3a3ee5eb608b930d200c45d623d0ea2f0431477a0ec0f1bc501"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-277.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "8ccd773e8deedf3efee535ff8af9a327779adc677c428f4536fdb9a090824337"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "ce307ad4f711d71ed7199ce4e6f3b2b2c7456b3b26a132023b8b960d01e1a78a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "b373aa4f838248d2c4bddf4774ce14bac468e621f8476986739526d6295bb26a"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "326f6085aaf3a6733f3cf2eface18513afbd07c70e4068c4da9c6880161ddb2b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "2be2031d600b8be3c73ff9ed56c8b2c304c5440a62f1e5e3a15446e76e7e3471"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "4c6f5139bde79f557af92790d219e64f1a2e043a657848e5618efbcb82f9b77e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "d3fddaabce691a316a2e3eb8c51f2bd46f53f073cf0e38b525cfc404f0a0d72c"
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
