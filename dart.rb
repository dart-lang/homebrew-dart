require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.8.5'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/42828/sdk/dartsdk-macos-x64-release.zip'
    sha256 '1b588537420d06f9d4b9a3ba43025054f0820c5b5d48b0b9050a32d0a129a071'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/42828/sdk/dartsdk-macos-ia32-release.zip'
    sha256 '55063b46c9d9852e70c150d3e2b720a6f2484a220164e7209db8a30c0fad0b45'
  end

  devel do
    version '1.9.0-dev.8.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/43715/sdk/dartsdk-macos-x64-release.zip'
      sha256 '4a74ce669032d572ada09270e9d3e9d9a4ba364231a552666b9cdac44f031a9c'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/43715/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '8bb8281f4cb711a2af9149139e1a7d78d103600217fb862b64b850787ad7f351'
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
