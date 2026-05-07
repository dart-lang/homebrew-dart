# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.13.0-103.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-103.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "33cb925f515ac9606ad2d08c6f75a54483befa1c407c4c0028a95932b08967c9"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-103.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "74058693e7101d0c6a7423651d1e4bde92e84610073127bdd3aef13f817900b0"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-103.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "90c1e47d12454eb1ac240207f6e4a9f6b4210bd788e4e2ec3ab0a95cc63ee900"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-103.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "35674a154c2f2e78fcaef47cbca7151155ef4b2eebfff8467b2c5ad85f5ac55f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-103.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "c096dce86eef084fe0b6a6b1124af4d3312f16c079228606dee46fec7db553da"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.6/sdk/dartsdk-macos-x64-release.zip"
    sha256 "81c726df7c196a5b481a51cec04c6c102c51c8e14c796f85759beeecced8721c"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.6/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "d3d888758f313af0cba74dcca157d2841772c96e0d47c64dd52bd54dcf11af76"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.6/sdk/dartsdk-linux-x64-release.zip"
    sha256 "ea0ff2396ea5af402ba3598a9139a0f4b1b3471d9d7e834882d1559622760add"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.6/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "3c1299f468eba0fd77cf9b82d7e768382c1e980837b60ca774a2ceb4f9d7db4b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.6/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ba594177d23c372c02a80dbeacd418094f78f44bfb67a60636cc32eafb662185"
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
