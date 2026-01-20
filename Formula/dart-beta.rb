# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.11.0-296.4.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.4.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "8e41d2ba8c2165bf9ce34c515e24420f2c3384c1ec7d90af60786453fe622e15"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.4.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "2a5cb1bb6bf8ff92be3b0638b9acb3f66ff76ce4e8a021f3c4cdd1f0e48752ba"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.4.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "9c33e9db6593e3ea9b06992a83d404099e1d3da4888651483a67d8c1debc6580"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.4.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "d6e641bbfadebb9ac490177f8e16978a01e964946adb592058fb27efbbbaf4c9"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-296.4.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "4809981696ab4aa3898ca0e58f209d38df564d31b379c76312f23eda7efb9b44"
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
