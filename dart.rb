require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.8.0'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/42013/sdk/dartsdk-macos-x64-release.zip'
    sha256 '4b86f91e01ef1a20140e0518f870ef8f506d3884315fe9d49acccaf416c2ff15'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/42013/sdk/dartsdk-macos-ia32-release.zip'
    sha256 '23504f50b219d81c5455e7f54c48b80f8cb8a6c207a9b8e81a4b9a259b2fcff8'
  end

  devel do
    version '1.9.0-dev.0.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/42033/sdk/dartsdk-macos-x64-release.zip'
      sha256 '5f27fad589d8cde28994b3e1a3c77d3322509f592cf871821f8521c3c6dc6381'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/42033/sdk/dartsdk-macos-ia32-release.zip'
      sha256 'be2c85c2021450a0fa7425300758c81d72960af01569cf0a3282a573f239e753'
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
