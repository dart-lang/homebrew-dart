# typed: false
# frozen_string_literal: true

class DartAT21 < Formula
  desc "Dart SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.1.1/sdk/dartsdk-macos-x64-release.zip"
      sha256 "2f80bbbc16b4cbd872f6e31912aa87a537412f3b417af99003521c8790542887"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.1.1/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "a19a73189f9dc2a3ff4557566c358b01774deab4811706e74e1bddeb43a76048"
    end
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.1.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "b223f095e2eb836481b6d5041d23a627745f0b45f70f9ce31cc1fbc68e9a9f90"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.1.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "8c7d359f00f3569dffd9d02fc213cd895a5c3e524d386cf65c89c2373630ca7e"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.1.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "9cda938c8ac285e03f53540267c5e514548f0a8d069463265e4eaf7d76fae2c3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.1.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "87614497b6b7098e294d116002861e1a7d7d982e4cd34026f80823f615248a22"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"].select { |f| File.executable?(f) }
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
