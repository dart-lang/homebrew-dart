# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-353.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-353.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "09b6afae37f7dc0eb970b5cbb88ea376a3a5b858a7c361c31fb54d6520b9f4ff"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-353.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "4b0dfd63118abe407ca82eef41668286eb607f3f822eede34cb728ddc7f6330c"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-353.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "3f226a1c88ddd6ad2aff1bb2687b45ee81caa905cb8d5eaa39bdd81593c4e860"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-353.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "eb273d0cfa506eb60ddf7c31ece5a1c0f155d7b029fa669d3eca4480eb2532a4"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-353.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "3c05b5cf65ee729ad45944f9403aa6aca5c817bf54961b9d07e347059f157d5a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-353.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "a2fccbf61899fe7623c7aa43e2f952a8e38bcf2fb1f5e058b3af79b2d220d3de"
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
