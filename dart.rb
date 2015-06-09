require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.10.1'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45692/sdk/dartsdk-macos-x64-release.zip'
    sha256 '0408c62995c24422dd3c0a34fbc23d46cda2d23848135e854c4811004a21881b'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45692/sdk/dartsdk-macos-ia32-release.zip'
    sha256 '30f05f40617ff63bd9ad73abd2cb5c227f034f226438150f74ccb10f94d6c6db'
  end

  devel do
    version '1.11.0-dev.5.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.11.0-dev.5.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 '603600518b0b36fe5bdc25ac9c7599fd2a232a56af23599c7bfaa457abfd482d'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.11.0-dev.5.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '0ff8a3efe1c2fd8b72fa5a043c55485d99d6e9506fa01d00d409d4956a7abcf6'
    end
  end

  def install
    libexec.install Dir['*']
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,docgen,dart?*}"]
  end

  def caveats; <<-EOS.undent
    Please note the path to the Dart SDK:
      #{opt_libexec}
    EOS
  end

  test do
    (testpath/'sample.dart').write <<-EOS.undent
      void main() {
        print(r"test message");
      }
    EOS

    assert_equal "test message\n", shell_output("#{bin}/dart sample.dart")
  end
end
