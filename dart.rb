require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.9.3'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45104/sdk/dartsdk-macos-x64-release.zip'
    sha256 '583bb67b00345eb490153a50a5f32d9cb78383fff21f0ecc3b7805b3f98b9269'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45104/sdk/dartsdk-macos-ia32-release.zip'
    sha256 '2e2c1920fa1e919c78432ecaa1bcd0a07b6a6adfe62703108122d20a03247056'
  end

  devel do
    version '1.10.0-dev.1.5'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/45201/sdk/dartsdk-macos-x64-release.zip'
      sha256 '8d57d7ab47f47feda7ecfeb3aae23664a7fcd7f30ed179260a257190486517e5'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/45201/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '3ae87dd4044e9297fd235933b32e75bbf7d2172f68f438a97d30436810ca9071'
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
