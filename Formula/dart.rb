# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.7.0-39.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-39.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "872469086f874c66edb76638607190894d54bae3c6aa0b601ebf3033a00fc0f2"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-39.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "17b8c7778bf5d9f96426994fa583db895905bbd2dda865677deca04dfd8a7c57"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-39.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "4f10cd466f02c59fb2fdfff9ed6bb3ff04d50304de53f65fc5a6d97bfd70f2b0"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-39.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "edcb20ac4ed66ae51f4b252c2e7cf83abc9802465af1b0d41647be9b68cc0059"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-39.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "33241dbcb03431c8512c56187ca53726e19e4f5722d4133ce61c4232c0a1a722"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-39.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "1450e6c3acff6f910cc31b05ca9c93ac854d6c11b888dca72a20ee0e78712885"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b06db3f3d0e92af0939ca467e87ecababa96da4f9fe5031a788304b5df949374"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c045940e0f5d4caca74e6ebed5a3bf9953383e831bac138e568a60d8b5053c02"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "8d0c5e34f2a9d6b9f5ebf05252ae1703893f6087d547c631b390aef2d0cd6967"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "2f90a98cfd45427555b06aac813f70573ed5882a512c3f2cf1e732ae53087b0a"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "a91d64dd3173349cee58c82f5ebf18bb9670f65eecc26d5684124c3def3f83ec"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f56d635ae4119f78ed887eaf8fb5e7821405fc10816d8ef42d3a9105c7ffb1f4"
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
