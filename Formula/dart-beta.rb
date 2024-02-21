# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.4.0-99.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-99.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "42426a35eae4cae5505125ff79bd39602acaace6525ffe72441cc85f12c183fa"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-99.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "bbda719328653b136927049867a872e4e0710e95c1d02da8252a7f2806838c20"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-99.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "023587c4f4329aae42f4a5927a0819da0b75f95665803fad2daa948e197b4d1f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-99.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "26eb0d66bebb3f1eb7a34ffc64d091308f97b0101fc746ca9c8bd9aa8892baf1"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-99.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b5ff698c87d87dfd729c953ec9a096fa868793ceeadc6509f688da8948d32d17"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-99.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "1dcf2f65fe5bfe433729d5fd8fb9d0d2cb70b4a5c64bea2a345e8151fb07eb75"
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
