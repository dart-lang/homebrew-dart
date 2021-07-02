# typed: false
# frozen_string_literal: true

class DartAT23 < Formula
  desc "Dart SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.3.2/sdk/dartsdk-macos-x64-release.zip"
      sha256 "2643c435c4c8fe1b39c9d73cb63ba8a170ac42609b6e91e08416911bc0418031"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.3.2/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "d92aa28a3c1742130f92e70c0bf767f7c3f6456392d7bc93fdefbfcfbb5a0e99"
    end
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.3.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "b693df23f9ff887ca1f5dd8240a96cb813dba1ec89100bc27b27915f19a1ab04"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.3.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "6f659edc1d7f06e1141a6b5db88382b8e2d9fcafd3e9de0b7af3749ce4a9033d"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.3.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b97253da172aa72ace982eb46779b35863ea3c1fea32951a407d761a0f7956f5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.3.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "d8ec28d7ca08555d6972e1054faa1a7b2bca78818097bfde98ba748a271f28ab"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]
  end

  def shim_script(target)
    <<~EOS
      #!/usr/bin/env bash
      exec "#{prefix}/#{target}" "$@"
    EOS
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
