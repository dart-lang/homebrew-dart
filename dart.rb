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
    version '1.9.0-dev.1.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/42241/sdk/dartsdk-macos-x64-release.zip'
      sha256 '5b44d30d98b2dbf0b96ed147f7b90e67b4979b5e06e71e73b2d9fa70b32c0b8c'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/42241/sdk/dartsdk-macos-ia32-release.zip'
      sha256 'f7f8805a67873524089b350ec5d8bcd10fc8649e1bed89433cc00a83310097ff'
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
