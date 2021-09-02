# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.14.0-377.8.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-377.8.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "1160b1ace8dededd5288c64302044e254e2c5b08b99d2b6650fe98e6f4b6cbbf"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-377.8.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "b7ba1bc95084b456be387501481e3e541ec35b0becebfd0800d8278d912ea60d"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-377.8.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "73ed9204792cd5c4a06ccffc98884c201ca23876a8fd01db133a7e7b5b28a0ac"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-377.8.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "cbe2bd3f757d1a1aa140fc94f42e5e0e75a329d4d41a6e5e2d3fa85775ffa28f"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-377.8.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "52dedfcdcce0dba900bc8ae0f0dcf0431d47a16a237613b150c35618a47d1487"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-377.8.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "c423847263f297cfabfecbaf0ca5d27c3e10fd6d4bfbfd0acbf6b8fc61c8b95e"
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
