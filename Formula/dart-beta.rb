# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.7.0-323.3.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-323.3.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "ba4b9a830486c0b536b7d2e91049ae70b20387851ee728f628014c0faa11b2bc"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-323.3.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "68844cb9a767066eaba9cd70704514ac9980ec580a4054e0cf9bfc221f72d5f1"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-323.3.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "d6a462d124ac3b48c7a662b74a7502e734d00f51f815b2b311579c0078daccfd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-323.3.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "52bbb0afaca958022a4ae390a07541b79c7bcd7fc134e58b49f78347de66a91f"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-323.3.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "d603f3a9020f64f59b68d8a746091c07afc38c8d8c23b0a75e21720a4da0bf4c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-323.3.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "83562e543537e1a2410ecc9cbb048ef4cdaa94ab837787a3973aeed552f98fe8"
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
