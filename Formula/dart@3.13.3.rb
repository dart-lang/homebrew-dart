# typed: false
# frozen_string_literal: true

class DartAT3133 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
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
