class DartAT2 < Formula
  desc "The Dart 2 SDK"
  homepage "https://www.dartlang.org/"
  version "2.0.0-dev.62.0"

  keg_only :versioned_formula

  if MacOS.prefer_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.62.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "3b5e140698bd4a9852523bfa5fbaa84472c18f1d02fad49ea632dfb1af45725c"
  else
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.62.0/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "97c6e2d8ef0636c21150ac1a3d8c2549c62b44ed6c96b5370534a87368db0555"
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
