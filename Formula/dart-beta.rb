# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.18.0-271.4.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.4.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "2604c669c94f8b72e447cf3eb579fbfeaf0f98da536165a9b3b457837b8105ab"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.4.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "fe2a9797d002ab3b10ee77a1fd075b3118033b0c018fe11eaa3211a2e3b9d65c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.4.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "d058dfd1487e7f8344b812f00ef4ee9dec455743a6c3c222c07c53083cbcd1e4"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.4.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "0a0b04d1731af84cd6592b47e08335389f6917406808af7374126d3aa5a63621"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.4.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "2c280eded97e7f42df56302ac83f910f1b0c059817870d953e5b356add0156a4"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.18.0-271.4.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "10a0d64eaa8e0ffbb229252ae08359a27af97a72026867e756c7c68a992d5544"
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
