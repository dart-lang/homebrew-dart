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
    version '1.19.0-dev.7.3'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.19.0-dev.7.3/sdk/dartsdk-macos-x64-release.zip'
      sha256 '00d8f2a03b5460c6071bcb61bff837662970b71bf59583f094c28beee85a2f63'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.19.0-dev.7.3/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '275d6bb3d2867c30a4f02b2b053c0a08846894c46c562b379a70104c6f240f01'
    end

    resource 'content_shell' do
      version '1.19.0-dev.7.3'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.19.0-dev.7.3/dartium/content_shell-macos-ia32-release.zip'
      sha256 'cc29404bfd2325cc563d24f77c464207fe837a4b57a1a4797c44147c2c7baafb'
    end

    resource 'dartium' do
      version '1.19.0-dev.7.3'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.19.0-dev.7.3/dartium/dartium-macos-ia32-release.zip'
      sha256 'f935cd581338e95d19222cb45c7520e1b5d6420ed70fc79f5b67938154d0f1c5'
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
