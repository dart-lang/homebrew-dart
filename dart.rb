require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.10.1'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45692/sdk/dartsdk-macos-x64-release.zip'
    sha256 '0408c62995c24422dd3c0a34fbc23d46cda2d23848135e854c4811004a21881b'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45692/sdk/dartsdk-macos-ia32-release.zip'
    sha256 '30f05f40617ff63bd9ad73abd2cb5c227f034f226438150f74ccb10f94d6c6db'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.11.0-dev.5.5'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.11.0-dev.5.5/sdk/dartsdk-macos-x64-release.zip'
      sha256 '0ac2a735e37de13bf92658b5b09e4ab32d90a7c89cc2ae6e861ba43f8a27196b'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.11.0-dev.5.5/sdk/dartsdk-macos-ia32-release.zip'
      sha256 'b71b546c2fbfceb72c12d74f9e6d93fbf9ab778e47719bf56794eec280f53252'
    end

    resource 'content_shell' do
      version '1.11.0-dev.5.5'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.11.0-dev.5.5/dartium/content_shell-macos-ia32-release.zip'
      sha256 '52f8dedb8f559c06bbcee102511f30fcd207e941bee98d2c5fb8fb37d1e031ac'
    end

    resource 'dartium' do
      version '1.11.0-dev.5.5'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.11.0-dev.5.5/dartium/dartium-macos-ia32-release.zip'
      sha256 '09c60c2f10a72e1d4a75d747ca0d763bdfc2b3ca35d6478bf603f397ee898fbe'
    end
  end

  resource 'content_shell' do
    version '1.10.1'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45692/dartium/content_shell-macos-ia32-release.zip'
    sha256 '7b50870dbe73bc7200f9d3da43c0fc7e301175cb7ac80c90e8d7ddc423f0b1b6'
  end

  resource 'dartium' do
    version '1.10.1'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/45692/dartium/dartium-macos-ia32-release.zip'
    sha256 'f981aa9074386293bcdc69b3adce8118ef7bdf801756d93eefc026f2095d4cc1'
  end

  def install
    libexec.install Dir['*']
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,docgen,dart?*}"]

    if build.with? 'content-shell'
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
        #{prefix}/Chromium.app
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
