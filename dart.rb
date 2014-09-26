require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  if MacOS.prefer_64_bit?
    version '1.6.0'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/39553/sdk/dartsdk-macos-x64-release.zip'
    sha256 '98fba491b86e70d7fc44ed69977b365b96f9d7d79a3a95a89553df9aafaf7f81'
  else
    version '1.6.0'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/39553/sdk/dartsdk-macos-ia32-release.zip'
    sha256 '2ad33e57098fb567c6b627d149899ad301de88f03edc92c74611956642eca382'
  end

  devel do
    if MacOS.prefer_64_bit?
      version '1.7.0-dev.1.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/39799/sdk/dartsdk-macos-x64-release.zip'
      sha256 'c721e896b313ae391a0601cc8a6a85fde0be96c107eae9677b752da9503b3f04'
    else
      version '1.7.0-dev.1.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/39799/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '2019455ed5b5e48d20e34c3ea9f233aa2a23a442a4025211e729d41e631f8166'
    end
  end

  def install
    libexec.install Dir['*']
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,docgen,dart?*}"]
  end

  def caveats; <<-EOS.undent
    To use with IntelliJ, set the Dart home to:
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
