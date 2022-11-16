# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.19.0-374.1.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-374.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "7e5105cfd18cf4a05a38f5fd484353664423c59c955743e48b7bbb73c356b1ed"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-374.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "f262db228b3caed2e767c8ec29aad2a538b4a2eb1c3e5dd673cdd4431be88cc9"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-374.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "b98711afbb54f1299135da84e67da843c10f4d3877ee5d3415011b757e199d0c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-374.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "0a24880de98f7ced821ea414a7e45def5b78c804eaac3f6fe07adf562b3de4a4"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-374.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "a1fd1d4025e343ef585f0fa463d10da66a6fb1e2fc070b941d678d38535a3fb9"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-374.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "27b4f867bfd898c98f7f7afd92c75a3b83e8ac39d493ef5477054ff11cd79baa"
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
