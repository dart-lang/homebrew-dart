# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.17.0-182.1.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-182.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "47d034f4bec55ea7cfdaf4c1af0221fcf07ffeaa731bd6a4978b2f9a238e446d"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-182.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "db1f7461ea290942571eca21f66d1b7440f0c45c16e2096cfd3cf437139a69af"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-182.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "edca0fe2afb7cb2a5d6c1ebc65cc9cf92db50940cad452de8ff0040272fe4444"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-182.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "b93950b541c24a2b46b69e17230a3443ec06d86ec74f4dfb6970a968336fc554"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-182.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "4bb7866c4fdda23e3d9603b27b3c669376b3740b7b9eca2feb8e9ccbc1673bb8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-182.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "5a6a93f26d38037c5de99f4b6dc6d9b61d30409f6e405e1704db337a4514e8ca"
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
