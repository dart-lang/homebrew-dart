class DartAT2 < Formula
  desc "The Dart 2 SDK"
  homepage "https://www.dartlang.org/"
  version "2.0.0-dev.68.0"

  keg_only :versioned_formula

  if MacOS.prefer_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.68.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "d0c4748ed453d82588986f36bb6ba06a67b0c2cafc8eafaab49b7aacb8a3c664"
  else
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.68.0/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "7bced650f92581f607709dce140df87111d54df9e176c802dbf2e8f37afd94a8"
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
