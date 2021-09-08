# typed: false
# frozen_string_literal: true

class DartAT210 < Formula
  desc "Dart SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  on_macos do
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "45c28ed3eb036edd1f5b0a7a073afddd1900f96abc3be085fe9335a424a228b4"
  end
  on_linux do
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.4/sdk/dartsdk-linux-x64-release.zip"
        sha256 "789f56cb6da0cfb2b97d9ea0942bc3f26fc20fd86256b1101e0147aa9790585e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.4/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "280701c2a225ef08bc14f5a2e7e2c75350b1ae3d78f7fd27cbb2a0b66674d83b"
      end
    elsif Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.4/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "13f085e477f93aa3884dbbcaaacb77c08d8ab6712b332a4f399b39f4c11be410"
      else
        url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.4/sdk/dartsdk-linux-arm-release.zip"
        sha256 "9f41091c8542fd50f0bd60fa9e5d4ceefe9c754a21684f802f89b54d2abeec83"
      end
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
