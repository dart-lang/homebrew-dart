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
    version '1.20.0-dev.0.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.20.0-dev.0.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 '2899ffecf78a6082a140cd469cd9df69c856515ff8bbea1137b93bf1877b3e44'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.20.0-dev.0.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '91f6c369f6a9fb46014e6aab60a257cfd4dcea3c3660c2513c8f747093b9a409'
    end

    resource 'content_shell' do
      version '1.20.0-dev.0.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.20.0-dev.0.0/dartium/content_shell-macos-ia32-release.zip'
      sha256 '0b24cd56d2be549ac501aea064dce6031c4d344581371f8f74fe392522fbf900'
    end

    resource 'dartium' do
      version '1.20.0-dev.0.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.20.0-dev.0.0/dartium/dartium-macos-ia32-release.zip'
      sha256 '836c49bf4367349aaca66ae81be69c6b3d65824127ef29202ca910c27ab6b35f'
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
