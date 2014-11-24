require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.7.2'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/41096/sdk/dartsdk-macos-x64-release.zip'
    sha256 '05c14f09c651c0de60dcd08dcbc7a9420707e18dcd145d88f9d23f6400b4c172'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/41096/sdk/dartsdk-macos-ia32-release.zip'
    sha256 'dba64cc9617cd02d33ee293d371bf376eaffd0b651165bbef40df4cee5687f54'
  end

  devel do
    version '1.8.0-dev.4.5'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/41923/sdk/dartsdk-macos-x64-release.zip'
      sha256 'd5edb1a2877272204a7e4eee156cde4ab0707007e26754aa2aa4b3f4fb2646b0'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/41923/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '0ad972ce46498eb89b5681759b138fca08e9bbfdeb8bdc4fc644ce19f09056c4'
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
