# typed: false
# frozen_string_literal: true

class DartAT25 < Formula
  desc "Dart SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b433b05ce353d3683c53632fdafd053aaab6c49014c8702fa63936cdc43ea8d6"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.2/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "f5c3f7b001a734726140e8941f0768f3365193d27024a762b769d7c03304064f"
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
