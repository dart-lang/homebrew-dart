# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.18.0-44.1.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-44.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "58b4d7596a9d437fc8a15dffe846d9db25a7a25fd147fb1a0dc4dc7546f9105a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-44.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "87bc791e472043e837fd021f48bc95efed495ddf2bd71e108871cc7f49fa3943"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-44.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "9f7915db20ce8e5a42f43e0501d74632c86e42aa0f8c7e6306e8ecc7a9007d28"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-44.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "408fbc1c393f2883a0a818a8489e1cb7d1ec49820c7af5ee8eb88353669450f3"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-44.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b81c548873460df0dd0107b58fd8a309cd6102182037460c6acad661f461ece8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-44.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "a9d526911da10257cbd1974b805b4bd0c08b74e6efc1fc8d3b47c1a09c68a05d"
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
