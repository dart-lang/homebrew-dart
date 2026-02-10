# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.12.0-113.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-113.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "75d80c87f04338adb4c41cf73f446498b164a0c5ad63409bb210a1eeccee943d"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-113.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "a6b3c595ff22f958996058915b09bfc1a5d4ad29e08f7c9f496613d9974f0f12"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-113.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "2ab623d25d47c57e968546704594ef7f958957c4735d2340f0f3fac93e7ff95e"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-113.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "ea3f5c3d24e89d72d1c90c625d030994bb5c45be382764e27dca1311fd5d9e0f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.12.0-113.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "f0655beb7c0703169e366ce8e59ca43f49f05c0451ad7c69e0fa829b21286b3c"
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
