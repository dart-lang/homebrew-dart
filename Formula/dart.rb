# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.12.0-70.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-70.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "d40a20373be92c480403279c5a6b1f8ec5183d7e7c214770c0d3b9faf3bf4010"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-70.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "57efbe8903d1a596e785b013f5c33576ec27286657baf9fa2448b9638ef7e723"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-70.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0d25546495ece906e1f51525caf1551a2b7ade5601451cbc249da07ace9ebcda"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-70.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "954bca6d3e9f92322d2f2677b5621922f3d4b153980ded549a2b0e61aa08f50f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-70.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "183df6b29b5efde6fbc6254a9e60af59f4b842e4344aa1e058e7784c7568b64d"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.8/sdk/dartsdk-macos-x64-release.zip"
    sha256 "1302ebc990d529eabe2233f379dc1171747742dbb71dc818048a1c2c059b6527"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.8/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "bd0e32381d48f7bc3403209a411d82c5f7c8f1bd88e92f0c4f392bf46ebc0e0f"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.8/sdk/dartsdk-linux-x64-release.zip"
    sha256 "6712007d16203f8928b402800ded0e92357426b83b02417d1573db9cc88b75c4"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.8/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "584eea4c53f64feda68eba5dc4b2b024275c21003dfccd85a79e934faaac0921"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.8/sdk/dartsdk-linux-arm-release.zip"
      sha256 "bf800929f939aa2e5278194b10e6f8abf8a29b72d13bdb49cb2460cb316178f8"
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
