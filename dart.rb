require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.19.0'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.19.0/sdk/dartsdk-macos-x64-release.zip'
    sha256 'cd60c7376f6030d02888416667b54b01c71d06b5ad3c33dee2e0255302ee6aa2'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.19.0/sdk/dartsdk-macos-ia32-release.zip'
    sha256 '6d75355a68236869d5252ed774a510de44a258c12224b2a04242e4914663fd49'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.20.0-dev.3.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.20.0-dev.3.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 'a9650f5384deedc4caf490b0770d718a4248d016459ee39613bfc2b4c25fd105'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.20.0-dev.3.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '975956dc2c519e0236afa57ab234d8157339b8ef83341ebb1b628346b79a2c6b'
    end

    resource 'content_shell' do
      version '1.20.0-dev.3.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.20.0-dev.3.0/dartium/content_shell-macos-ia32-release.zip'
      sha256 '73c5ba7d2b1a426dc531b09ae16cd4ab0d3ed37d82313f82521fec04dea3753b'
    end

    resource 'dartium' do
      version '1.20.0-dev.3.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.20.0-dev.3.0/dartium/dartium-macos-ia32-release.zip'
      sha256 '75d0d9fcee69355e87c2f5c0b2a566a47def0a376eb8b12da5330a1efdd2e01f'
    end
  end

  resource 'content_shell' do
    version '1.19.0'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.19.0/dartium/content_shell-macos-ia32-release.zip'
    sha256 '120da4444bb33145e46617ef340ca0c9e8c62292fccd363ad17f100b1b83a456'
  end

  resource 'dartium' do
    version '1.19.0'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.19.0/dartium/dartium-macos-ia32-release.zip'
    sha256 '27ea5c85780665ce1b417dc05dac988cfd3e20bcde422b5d0c5c0a4f21bd05e0'
  end

  def install
    libexec.install Dir['*']
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]

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
      #!/usr/bin/env bash
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
