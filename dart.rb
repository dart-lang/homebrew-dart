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
    version '1.10.0-dev.1.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/45054/sdk/dartsdk-macos-x64-release.zip'
      sha256 'f85c1a2338fdf2a67f57d0bd4b615e448cb920108cf7ae79f65a2b59350bbb15'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/45054/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '886b87025d35dafaed2e94020d15d767feae0885e0bffdd0314eaeceb390e2eb'
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
