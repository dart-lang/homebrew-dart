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
      version '1.7.0-dev.4.5'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/41004/sdk/dartsdk-macos-x64-release.zip'
      sha256 '784ff69f018bc62b1f930b10e603a4c100b2e55eb892168ba1f128d861f93b2a'
    else
      version '1.7.0-dev.4.5'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/41004/sdk/dartsdk-macos-ia32-release.zip'
      sha256 'd6b285b8c7a51eb1406a6e0de6e8b1f7840cc226febafaf6969752bedb9e9cc2'
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
