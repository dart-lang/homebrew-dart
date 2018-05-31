class DartAT2 < Formula
  desc "The Dart 2 SDK"
  homepage "https://www.dartlang.org/"
  version "2.0.0-dev.59.0"

  keg_only :versioned_formula

  if MacOS.prefer_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.59.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "dfd929ed8b07278247b041d7573d5bb966033030c9c0122dee6b0eb0b6515850"
  else
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.59.0/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "3fc86c5f5e88b9f652364b33de547abf6e59033a35931eb63e0c89349f64c466"
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

    assert_equal "test message\n", shell_output("#{bin}/dart sample.dart")
  end
end
