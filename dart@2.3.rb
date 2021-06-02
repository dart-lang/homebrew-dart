# typed: false
# frozen_string_literal: true

class DartAT23 < Formula
  desc "Dart SDK"
  homepage "https://dart.dev"

  version "2.3.2"
  keg_only :versioned_formula
  if Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.3.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "2643c435c4c8fe1b39c9d73cb63ba8a170ac42609b6e91e08416911bc0418031"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.3.2/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "d92aa28a3c1742130f92e70c0bf767f7c3f6456392d7bc93fdefbfcfbb5a0e99"
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
