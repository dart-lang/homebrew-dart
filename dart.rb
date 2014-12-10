require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.8.3'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/42039/sdk/dartsdk-macos-x64-release.zip'
    sha256 '106be0cc9add495ab8d986083cf9bbe9439bbcb66847c0ecd851b61048a402d6'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/42039/sdk/dartsdk-macos-ia32-release.zip'
    sha256 '7bd85cecf78a5f438146d66c37cf3cf647c1114af562b8212a62fb85116ad576'
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
