require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.6.0'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/39553/sdk/dartsdk-macos-x64-release.zip'
    sha256 '98fba491b86e70d7fc44ed69977b365b96f9d7d79a3a95a89553df9aafaf7f81'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/39553/sdk/dartsdk-macos-ia32-release.zip'
    sha256 '2ad33e57098fb567c6b627d149899ad301de88f03edc92c74611956642eca382'
  end

  devel do
    version '1.7.0-dev.4.6'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/41090/sdk/dartsdk-macos-x64-release.zip'
      sha256 'cd6f213291e9c7ac7a8eeaf9681460a6bb0366e0caa94080ddf3b49d1183c7b4'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/41090/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '3795c1f48107a13639523e4321ace053e99b65a99ea8bbfaac83a9b81bb3f1a6'
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
