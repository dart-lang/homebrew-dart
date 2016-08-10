require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.18.1'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.18.1/sdk/dartsdk-macos-x64-release.zip'
    sha256 'b298c2096d5df79910716621525d5f360ea22cc967c42d48e90b60da9490a204'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.18.1/sdk/dartsdk-macos-ia32-release.zip'
    sha256 'ea535fcee3ea14f18380f3ce76859567e35b696adf215ed8d2bf777475e88dc3'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.19.0-dev.5.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.19.0-dev.5.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 '0058bd2118394a255efa3c2061ba7543bdb0b3377abeeac9c82664efff5cc61d'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.19.0-dev.5.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 'f8f3b95a2a381d0a8f253b512eacbf9d230695ec9fcd01ff68d5bfceebd38dfb'
    end

    resource 'content_shell' do
      version '1.19.0-dev.5.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.19.0-dev.5.0/dartium/content_shell-macos-ia32-release.zip'
      sha256 '8e5fa2403249155b85adaf71fee3426789f704397e48f80377f0f0eb872120d5'
    end

    resource 'dartium' do
      version '1.19.0-dev.5.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.19.0-dev.5.0/dartium/dartium-macos-ia32-release.zip'
      sha256 'fc191b2281a5d89b314224e548ada62642f8fbb14e25ec3b2c7f57a47827c7fd'
    end
  end

  resource 'content_shell' do
    version '1.18.1'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.18.1/dartium/content_shell-macos-ia32-release.zip'
    sha256 '5f3e838204bee91d7e605fccc74e8ef5e5509a2b29836e20cfa2e9a6cf5fd5ea'
  end

  resource 'dartium' do
    version '1.18.1'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.18.1/dartium/dartium-macos-ia32-release.zip'
    sha256 'd7ec6d7a69a73bb8fe429677588cd364901f3effbdf11585777c3434f0c561d0'
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
