require 'formula'

class Dartium < Formula
  homepage "https://www.dartlang.org"
  release_version = '42013'

  version '1.8.0'
  url "https://storage.googleapis.com/dart-archive/channels/stable/release/#{release_version}/dartium/dartium-macos-ia32-release.zip'"
  sha256 '5678d7f49e0f1282aaa8d10afc3f87e4ebf4684277d66c2b44cc71f20f05142e'

  devel do
    dev_version = '42033'

    version '1.9.0-dev.0.0'
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/#{dev_version}/dartium/dartium-macos-ia32-release.zip"
    sha256 '5909f9289b68b5c334a5be2cc3cd7664ab3151f26b4817fcac7d6f1601646b20'

    resource 'content_shell' do
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/#{dev_version}/dartium/content_shell-macos-ia32-release.zip"
      version '1.9.0-dev.0.0'
      sha256 'b78836ca14786542898e34ad806c94852b258575a559d82ad1e84d850627c5cf'
    end
  end

  resource 'content_shell' do
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/#{release_version}/dartium/content_shell-macos-ia32-release.zip"
    version '1.8.0'
    sha256 '93fe4ca002192a9be92ca7b616ce3a3ab0050a2a54c7a84ad39328884d0b75ea'
  end

  def shim_script target
    <<-EOS.undent
      #!/bin/bash
      "#{prefix}/#{target}" "$@"
    EOS
  end

  def install
    prefix.install Dir['*']
    (bin+"dartium").write shim_script "Chromium.app/Contents/MacOS/Chromium"

    prefix.install resource('content_shell')
    (bin+"content_shell").write shim_script "Content Shell.app/Contents/MacOS/Content Shell"
  end

  def caveats; <<-EOS.undent
     To use with IntelliJ, set the Dartium execute home to:
        #{prefix}/Chromium.app
    EOS
  end

  test do
    system "#{bin}/dartium"
  end
end
