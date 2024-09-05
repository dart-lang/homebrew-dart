# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.6.0-216.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-216.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "9a4e0de295d16360d27df11795461993546cbc3232442fa4c46d23fdee73a95b"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-216.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "159afebca63d12bb6cb024ee3e8a4f4fa52973735983de2cce504f7a0ec52f67"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-216.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "9cd1436875df2299df48e238b3353678f620ac066e706c35c805403099733b52"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-216.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "6936860bba1ff9a137e523d444bac74e0c5813454fb0ebf0ba3396198e8640e5"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-216.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "a592f8b23d62b5ff902525bb0c47ab7f82aee0ce27588ea559717998b262cc57"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-216.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "76931a9e6e354a63b3ec7243c1c99d0bd4c5425d71b48f3b2fdcf933d12ea8b1"
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
