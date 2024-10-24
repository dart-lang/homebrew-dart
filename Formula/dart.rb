# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.7.0-54.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-54.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "c8872798e78c17e69ac80a1a79c27bd75432886a58b70eeb0bf3ac43eb360208"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-54.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "5668b23a0cc70019881a0bef0bb7aba3aa53a1be6b6e65752f7bfa72c29a5331"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-54.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "0bc781ec979a50963040bef62dffe11753351fe34e3d015c0a325a64930de9b8"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-54.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "3bb13a57e92704be313e9be60e5475325b560aa159dda179997844df945f38f5"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-54.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "05ede3840691d02b9a379017d3dbe7c4d09ac746bba9617919890df4a49c22ad"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-54.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "e2453d62fe179ad1183c1d08e69b97c9ebb3e3566bd2f11db75d9d9e6117ba98"
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
