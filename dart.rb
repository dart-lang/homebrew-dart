require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.9.1'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/44672/sdk/dartsdk-macos-x64-release.zip'
    sha256 '919908f1a315a1b7042522362dc656b5566ce5c2dc8f47c07140370b824b8c73'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/44672/sdk/dartsdk-macos-ia32-release.zip'
    sha256 'c2ca6250957fe61ac1131be70b212644f6e184b5ce1b4ce842339ed203d45005'
  end

  devel do
    version '1.9.0-dev.10.13'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/44630/sdk/dartsdk-macos-x64-release.zip'
      sha256 '22538163b6390d42fd71cf8fdfb8590afae3f412e345efb735cd5bcd0eb77717'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/44630/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '4304228196190352a4eb9af90ef69104443ed1417e4e108ecfec78daf730b834'
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
