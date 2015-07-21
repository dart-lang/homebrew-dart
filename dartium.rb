require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.11.1'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.11.1/dartium/dartium-macos-ia32-release.zip'
  sha256 '795fb4fd1681071cda62c69713f1be505270c6fde75964ea025fb39457a0434f'

  devel do
    version '1.12.0-dev.4.0'
    url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0-dev.4.0/dartium/dartium-macos-ia32-release.zip'
    sha256 'fd5631759129696eb5d01ee6675bdeab1eab6144967327e2633e4442e88d5842'

    resource 'content_shell' do
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0-dev.4.0/dartium/content_shell-macos-ia32-release.zip'
      sha256 '11ce03ae2d6f6b7d479e2ce732b3ce0942a8a49c9888f18b55d0331e97f2345b'
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
