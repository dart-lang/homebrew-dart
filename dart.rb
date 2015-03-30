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
    version '1.10.0-dev.0.1'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/44728/sdk/dartsdk-macos-x64-release.zip'
      sha256 '11fb92565aef2a44884cdd183c00647bbdb2426d4bdb6238178e92c3005b6e56'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/44728/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '8842ee9f2a9e065804e04d1a42e0a54aa385f053092c5d7ffbafa383266b4975'
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
