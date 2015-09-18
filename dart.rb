require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.12.1'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.12.1/sdk/dartsdk-macos-x64-release.zip'
    sha256 '1e40ac0c68c1ac9076e1c9e80f2ab77c1a603dc63ee471613191240f436b4047'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.12.1/sdk/dartsdk-macos-ia32-release.zip'
    sha256 'f3ae21478e5531ec2d758825f348a524129db3f2a551adafd0861c6a33209b51'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.13.0-dev.3.1'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.13.0-dev.3.1/sdk/dartsdk-macos-x64-release.zip'
      sha256 'bd36ef63b5e6e8bdd693a742ad43a9ac389bbb172c5e01d47cef26745940de4a'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.13.0-dev.3.1/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '4fac5786d44cfd438cdcfba09b2db009473f9338dcca2c50fda5dde3a852b28b'
    end

    resource 'content_shell' do
      version '1.13.0-dev.3.1'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.13.0-dev.3.1/dartium/content_shell-macos-ia32-release.zip'
      sha256 'fc71c058f203bbbdfe67cfadd4f644af08b6863a2d826fea4ee1291cd7086f54'
    end

    resource 'dartium' do
      version '1.13.0-dev.3.1'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.13.0-dev.3.1/dartium/dartium-macos-ia32-release.zip'
      sha256 '626e6d51fddf836334a0abddbed3f8951b2cb08b0d10c00453cc00b0e3914ac4'
    end
  end

  resource 'content_shell' do
    version '1.12.1'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.12.1/dartium/content_shell-macos-ia32-release.zip'
    sha256 '50429d1266e7588466dcdcca0441c4ec8bfb09162ed7e6705874242f3944ae9d'
  end

  resource 'dartium' do
    version '1.12.1'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.12.1/dartium/dartium-macos-ia32-release.zip'
    sha256 '9a9c72b7ce707691702f9284ee350e3e9565d4f8b90fea846d1d215f97808788'
  end

  def install
    libexec.install Dir['*']
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,docgen,dart?*}"]

    if build.with? 'dartium'
      dartium_binary = 'Chromium.app/Contents/MacOS/Chromium'
      prefix.install resource('dartium')
      (bin+"dartium").write shim_script dartium_binary
    end

    if build.with? 'content-shell'
      content_shell_binary = 'Content Shell.app/Contents/MacOS/Content Shell'
      prefix.install resource('content_shell')
      (bin+"content_shell").write shim_script content_shell_binary
    end
  end

  def shim_script target
    <<-EOS.undent
      #!/bin/bash
      exec "#{prefix}/#{target}" "$@"
    EOS
  end

  def caveats; <<-EOS.undent
    Please note the path to the Dart SDK:
      #{opt_libexec}

    --with-dartium:
      To use with IntelliJ, set the Dartium execute home to:
        #{opt_prefix}/Chromium.app
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
