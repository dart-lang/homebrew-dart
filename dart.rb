require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  require_relative 'dev_info'
  require_relative 'stable_info'
  stable_version='1.6.0'

  version DartStable::VERSION
  if MacOS.prefer_64_bit?
    url "https://storage.googleapis.com/dart-archive/#{DartStable::SDK64_FILE}"
    sha256 DartStable::SDK64_HASH
  else
    url "https://storage.googleapis.com/dart-archive/#{DartStable::SDK32_FILE}"
    sha256 DartStable::SDK32_HASH
  end

  devel do
    version DartDev::VERSION
    if MacOS.prefer_64_bit?
      url "https://storage.googleapis.com/dart-archive/#{DartDev::SDK64_FILE}"
      sha256 DartDev::SDK64_HASH
    else
      url "https://storage.googleapis.com/dart-archive/#{DartDev::SDK32_FILE}"
      sha256 DartDev::SDK32_HASH
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
