require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.11.1'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.11.1/dartium/dartium-macos-ia32-release.zip'
  sha256 '795fb4fd1681071cda62c69713f1be505270c6fde75964ea025fb39457a0434f'

  devel do
    version '1.12.0-dev.3.1'
    url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0-dev.3.1/dartium/dartium-macos-ia32-release.zip'
    sha256 '48eea11e7307057e1b7f85bb43e8db4408d8d42e5b835ab01b9c24a7e6a28f3b'

    resource 'content_shell' do
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0-dev.3.1/dartium/content_shell-macos-ia32-release.zip'
      sha256 'db9a55647faab694d5de87a49c95ab121eb6fd136f9db5e58d0391cd51e265f8'
    end
  end

  resource 'content_shell' do
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.11.1/dartium/content_shell-macos-ia32-release.zip'
    sha256 'cbde87a5becb2ca4c8256e624a2eab6943df26f58125cb2b65cc38496c15f3a9'
  end

  def shim_script target
    <<-EOS.undent
      #!/bin/bash
      exec "#{prefix}/#{target}" "$@"
    EOS
  end

  def install
    dartium_binary = 'Chromium.app/Contents/MacOS/Chromium'
    prefix.install Dir['*']
    (bin+"dartium").write shim_script dartium_binary

    content_shell_binary = 'Content Shell.app/Contents/MacOS/Content Shell'
    prefix.install resource('content_shell')
    (bin+"content_shell").write shim_script content_shell_binary
  end

  def caveats; <<-EOS.undent
    DEPRECATED
      In the future, use the `dart` formula using
      `--with-dartium` and/or `--with-content-shell`

    To use with IntelliJ, set the Dartium execute home to:
        #{prefix}/Chromium.app
    EOS
  end

  test do
    system "#{bin}/dartium"
  end
end
