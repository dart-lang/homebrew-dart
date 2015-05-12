require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.10.0'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45396/sdk/dartsdk-macos-x64-release.zip'
    sha256 '9c1b363147898771643bcdaae84ee38c4b459981ba7f62722c200d13222b7855'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45396/sdk/dartsdk-macos-ia32-release.zip'
    sha256 'd1553c57d6663e1819406760079a75cb62a24cfe662a1b33d81eb9e6533328bf'
  end

  devel do
    version '1.11.0-dev.0.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/45519/sdk/dartsdk-macos-x64-release.zip'
      sha256 'f72dd10f7ffe554e8d2e1e506d671b187e803cdf1fd30db545d9aff970bc4f59'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/45519/sdk/dartsdk-macos-ia32-release.zip'
      sha256 'd859d25e2de9281bc827f72b8d7851956058ce5f303ee0844e817591e99f3848'
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
