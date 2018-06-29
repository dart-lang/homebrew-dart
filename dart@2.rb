class DartAT2 < Formula
  desc "The Dart 2 SDK"
  homepage "https://www.dartlang.org/"
  version "2.0.0-dev.66.0"

  keg_only :versioned_formula

  if MacOS.prefer_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.66.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "80a7a672f8bb53d61689ce1fbd89fcab4015a8aa18f0527630d580f9ba520b25"
  else
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.66.0/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "ee4e2f11613881e7803c1607a8af626257b6bd2c61fb959f7a27e5602c3b670d"
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
