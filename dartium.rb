require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"

  version '1.11.0'
  url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.11.0/dartium/dartium-macos-ia32-release.zip'
  sha256 '59d11a84e096c7959756394737e4370cbe5a483d5b7169cde7b8199b12a07098'

  devel do
    version '1.12.0-dev.1.0'
    url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0-dev.1.0/dartium/dartium-macos-ia32-release.zip'
    sha256 'ef677a922e1ab1edd6447d3b149cdd2c65f9f73bda7562e0452b6135fe6694a5'

    resource 'content_shell' do
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0-dev.1.0/dartium/content_shell-macos-ia32-release.zip'
      sha256 '2932077fff5f304eba14376b127355f977a6db82c02038eb04afb039007e44c2'
    end
  end

  resource 'content_shell' do
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.11.0/dartium/content_shell-macos-ia32-release.zip'
    sha256 'ed7e687ce6eb717d195d0c5013f1efe15f9e384fc080fee525eaebbc9e1e6eb9'
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
