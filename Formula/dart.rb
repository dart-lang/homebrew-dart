# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.14.0-219.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-219.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "586fa71ec6ba169cdc0159a476a74d223e5b4b9d0eb5138bc57fbcd13347a723"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-219.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "bb674d6c08630eb5b904a6446fb27c1f4607dac08e4b09fdff2e20445a5750c5"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-219.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "7b3ed5f4dede580e7bf85cce114e7fadea9cb8264f3fd0008b473b2b279ba102"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-219.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "5eb1934195414dd7a0959a58c5d1a95b1d95ee7e4f59a398d14b1f9fa4070c44"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-219.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "eefafb3c5b51a0381397310ff5bd364ff9089a240da42aad47fc138eb6451a9e"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "df957f34954c03c6551ff1ca7ce0c31038039689345f8b4d658aa5e69e28495c"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c703bcbb25ca0cc5df9109fb8272d52786ac14782437bd9e365a01985273c1cc"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.3/sdk/dartsdk-linux-x64-release.zip"
    sha256 "549c182cffbdc6864df7509c16fec646c73fe6cb8a18c2cb572db1292f300cd7"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c59c535623f3ab9717e8755237df695f153fb3af3bfb0f6c281b2eb4fefe669e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "404cf65532c20a51dd5831c089fec252d04c187f0a46a7e73d1121fae8e2a4d9"
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
