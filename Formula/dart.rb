# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.9.0-203.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-203.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "9ecf9a7dcfa68cc8aa0654e48850a7756df1b659e1a380a166a1c1962b0a922a"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-203.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "2f86772d8f8cc83a9a78bd982cd11606a837bbf21405973b943c5a596bd01feb"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-203.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "b520a4d40b88c0fba142646da16352d8446d81e962b71c15040665899e66b82b"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-203.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "5cebad2ddaf0bdec1a8ee2bea586af17fb40aca64ab9ca483e937df3e17f9fd2"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-203.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "6d983ec12b50c15aa5f390d76b2c40fb0ae7ce0ff701e6c53a5efba2b0471e5b"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "39371df3d64f94f5b3d9c1119c3f549164c5628c6a13b9451b7b44859f1f9114"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "5080bc6f4a78ccce0e38e71e46476c08d61e081453646948f3f0c77177a928f8"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-linux-x64-release.zip"
    sha256 "0d58c010a361f3f1588b1c2f57942f7ccaf7b7abbe03404fef7a102eb638f09d"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "78a3240097bee3b79b009c69ead22e1aaedededcbe093eaa980084c5661096c8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "02adb724b0b684573f7630b3d79ef729f8cf9fff561f5170bcc195ee2477e1e6"
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
