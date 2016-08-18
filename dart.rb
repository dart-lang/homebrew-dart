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
    version '1.19.0-dev.7.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.19.0-dev.7.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 'f7dd186d682de0407544ea870f83a21bd8ca2d5aad901974f304646192518f11'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.19.0-dev.7.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 'f2a9df3c348ad0284c93bf9fd71bc1d4e924abb95813e43ce639534ac37cf920'
    end

    resource 'content_shell' do
      version '1.19.0-dev.7.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.19.0-dev.7.0/dartium/content_shell-macos-ia32-release.zip'
      sha256 'fc14dc069ada4cec7e863c5f41ff65204087a83e15b898f78da8d6ee839d7bd1'
    end

    resource 'dartium' do
      version '1.19.0-dev.7.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.19.0-dev.7.0/dartium/dartium-macos-ia32-release.zip'
      sha256 '96410e09056dc4e084f2ddf5fed1c759008380a5fdfe37796ba5b14a432b08a7'
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
