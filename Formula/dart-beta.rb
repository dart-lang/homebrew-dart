# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.1.0-262.1.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-262.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "a6b2b1f9e80d188fc45220142d7af0f97f3fd21e58fbb5b3959d4cce88183b71"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-262.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "f1664d53b991ec3af18bfe70bd4b5bc0fb27d0ac1ad91b0d493d9cf2f1a3edf2"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-262.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "18f959e4361833fac9421bfba51341df1141bfff16c1261852de7d87d883f2ea"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-262.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "afe407fc2e28b11dbbf7f3d74b9c4682ccded2a595f7f06a26a7bde56bcbde12"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-262.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "3f54e64b2974c232f4580c2103ace293b6f5070976f68632629f392843016779"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-262.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "8a9e840c238aa7a5c16f47d92e7edb8883962a08e32bf474de9a674182f21619"
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
