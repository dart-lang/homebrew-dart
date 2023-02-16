# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-236.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-236.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "dd4821f5406e9d27ee5a43aec6d0fe7570d839ba38963e83b546a8b1eaca2823"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-236.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "a09dad44cb7a61b41f3b39356377aca150ddb4fdee116bbeea054a97a818a31e"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-236.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "a54f12542d289c1ec00c913a85a84d8554e405739bbe5c8ebf74ee95ea5fc305"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-236.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "26ce8fc245b7074e42e8046e61c7f6d221b5f0993bea18f7d4ec4e4085acf7c9"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-236.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "cb269e8e1634d7f91488d2aa87ef9d1c3c264a80fab55c5f16befb499bdd1095"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-236.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "0f3ebbbf6ae912e37aa43866247d9ecabeb8e8d146b756b98d68cb995693cbd9"
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
