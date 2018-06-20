class DartAT2 < Formula
  desc "The Dart 2 SDK"
  homepage "https://www.dartlang.org/"
  version "2.0.0-dev.64.0"

  keg_only :versioned_formula

  if MacOS.prefer_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.64.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "52ea77f802ea05585f2fdc8d2e2e925dd2cf06c11e426ae8e1ff43c3158c5f16"
  else
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.64.0/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "46646bc7f4942aa4e7dc108415381a83be74e4012a70eb5c04bc97bcca436f25"
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

  def caveats; <<~EOS
    Note that this is a prerelease version of Dart.

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

    assert_equal "test message
", shell_output("#{bin}/dart sample.dart")
  end
end
