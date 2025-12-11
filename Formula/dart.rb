# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.11.0-219.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-219.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "b3ac7dc1f88df84f641e3f022cba0501cb7a6c7fe7cfc9fad4c8c95e51aac5a2"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-219.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "29fd8156b521204583f0ea22cb2be2ccc3f640b5e265dda9fbf8f1382382498f"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-219.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "71c08b7b460e89a10ea50bdcdebb1a0267b7139f7dd9ab6b9be55cc1b5b829db"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-219.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "c52a690f5ebd28079ef7ea38dfcd60b67aae4abff4f3a4b53845b52e560ded0d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-219.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "8509abefa77a7e4c58e9535eb329292926b8ae09cddd3d65c1f117a1e010957d"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "29f6c7c28c635ac839519306c3ac1371eac9fbed4ff48b9bf58c3cf7cd1d76e6"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "724b64f7afe3847c8624c3b63ca709e93f498f586609031f7da48d8f1fa49147"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.4/sdk/dartsdk-linux-x64-release.zip"
    sha256 "60a9a34eb1165d331d776dc89fb4fd43b9d8bdaf2ca137c1fdcf98d6c89abeec"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "828faa614fc2dfcc0d0b44ec646f95d69433124ce0c81a546e75ddd8a5f9a4fa"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2dd412046e8d9fbe429c6fb5f1c042b27f081720c1f1e36a25cc367b7bbe7c52"
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
