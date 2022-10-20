# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-318.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-318.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "efd6fa6fca1cb7f909d1f854a31991c334599a3b19cd348d9f7f36c4b7a80b91"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-318.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "be1daa97dbc3c2e2413f3692382219165abb75d784a6cbdd4b261c1464968cdc"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-318.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "50e840da5d1f6761287b15d4ef4ab7a998bfc751853504455d0e6439ec1015e5"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-318.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a72d260879d2575a1c14c0e2236cd830c47c99314188b4783f17c1bca9290b37"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-318.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "514a598e963aa6781c3df4bb88882ce5c0f31097a45cdcaeb2013dc9d3539dbb"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-318.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "2338f3d4f96a0586de01cfffd4632c5f8d4d620d2f4ba902c625ffb2b0c68309"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "52ba7072694f7d782633274440fe717c6ac300d4ba4fdbc24bdcd2bae77f4995"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "7295fb2159879aca7dc829be9b123e24d18812ee7108894da5d521724e8e278f"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "77ffe06da481ce420463349d339998dcb122f8c7a857ab96acd35a4652d47e3d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "158facce774258859f5c7a51bda65b981c182fa11a028c154ff032b1302d6add"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e7ddd9e8c7160b72f61af674e8715f01df4ad445a92685cf86f7b0701fb44027"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "0e5f0f3bf591bbc0a8561171ebfdba3a2da566600d4fcdd6bd6a614201c304e0"
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
