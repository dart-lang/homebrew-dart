# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.8.0-108.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-108.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "0896ffba3aee1f693319e042a2ff0a40c3dd65cc278129e01db6b04e760b135a"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-108.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "979811a08a8bc2e6230dea4d6b9515cc93082b2017628b15ee88cc63e419f93e"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-108.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "25f239c8866f23a07073f780dd5ebbb00e0768474a8d1f3d46ba7a6f2642a7ad"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-108.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "7ac94e761c2620746e130b71ef8154a98b3a5b3afb397deefe5305971165f875"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-108.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "9b8c88dbaa343b1768dbd2158a350355da7c9ca27078b5782eb812a0f1e1d7bd"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-108.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "5717f8430e059a01ce41cbd4551c4700d2acbd7cc854a3387bc2be5352c96430"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "d601c9da420552dc6deba1992d07aad9637b970077d58c5cda895baebc83d7f5"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "9bfd7c74ebc5f30b5832dfcf4f47e5a3260f2e9b98743506c67ad02b3b6964bb"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "367b5a6f1364a1697dc597775e5cd7333c332363902683a0970158cbb978b80d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "d6998083720f01825b7d75bece26cc11e467edb3e8b3b46d02dfc1e01b06d52e"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "7c849abc0d06a130d26d71490d5f2b4b2fe1ca477b1a9cee6b6d870e6f9d626f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "03842c2037f99450a1433f5dab9dc1820686eadf92f517929d0306cbbe92ecd2"
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
