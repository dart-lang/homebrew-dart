# typed: false
# frozen_string_literal: true

class DartAT25 < Formula
  desc "Dart SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.2/sdk/dartsdk-macos-x64-release.zip"
      sha256 "b433b05ce353d3683c53632fdafd053aaab6c49014c8702fa63936cdc43ea8d6"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.2/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "f5c3f7b001a734726140e8941f0768f3365193d27024a762b769d7c03304064f"
    end
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "afdda5e7b2a357fed2fec9511f12b4c4317d04b5a87e439a27d107104e98095e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "ec4291d0c57d36dcd9374428aac98a0fd7ee8f1ba30e1fe87d5e009d491a7b95"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c45465e25a299a9cb4c5c0c8dabd1c277eb25e6f409a28c0a286204474683075"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "16a2cce0bece594db4a9a89b7289b378763d708895bd63efbcd2dfce78487471"
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
