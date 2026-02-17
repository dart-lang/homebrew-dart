# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.12.0-145.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-145.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "6a6fdb5ae27d167c047c245d8dc52724a91194590463d643d22ab19e94c527cf"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-145.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "1fef2964e6a3e726b4bee1d02766e7c727ce36c1f6a2defea92b663cf50f09e6"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-145.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "152c11063981959e34b21d25d99da17bdd4c54ccdf46ec20fe06e759a3542823"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-145.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "99dbd00068859785e188d095594b0ed4b887f2c14fcbcfdfdc5be8add0e61a0b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-145.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "6fbdfb7c3555b0e3b22c526b8f6ac2e0f1faab24e8fec879bf5fede71189b435"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "5a5c29c7a8381269332801326b11ccadcf0cfe7301ed01a3f06e81766bcb8d74"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "223245a42eab1b811e502e15625b867075ffe012de9eb5374a4cdde2ee087534"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.0/sdk/dartsdk-linux-x64-release.zip"
    sha256 "f31729b567be318c7cc23bdafe6b9a997fa7ddbf829df5016f066227b6aa0c99"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "76bfef5c809c082177df6c51bbf4800d8d4d755f2e96fb75162bf8d2b032ef83"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "544e6137a072d73451148db128bfeb7fb73992615537b81d641b3396983c6884"
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
