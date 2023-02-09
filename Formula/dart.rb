# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-218.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-218.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "ba59a63b95eb9b9471630c5f39c0d74351e4525af32d81f3face7c0f76958cc6"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-218.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "f656b4d4c4b2822dcd4997dc74ebe937579cc9a656f580dd3142aaed53262be9"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-218.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "086679e315a17401335331868822178d230056b9a6569ea3f7b02f38c412749a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-218.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "d92ae198335575217eae16f16fe5540374a10ab291b708c549251c9a51d4df25"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-218.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "ce0f85cdd72964549f255c1eaea4ef5d3d4c52dc8f024e5bed3d93f360264229"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-218.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "3e337a45bf77fce487c626e0309c3e22e0bb1019dc9c16a17d5856a01cc3e4e8"
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
