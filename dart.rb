require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.13.0'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.13.0/sdk/dartsdk-macos-x64-release.zip'
    sha256 'a0209501a2b3eb461f4592c72883404b018d3e3d44c09745e6ef87954232681d'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.13.0/sdk/dartsdk-macos-ia32-release.zip'
    sha256 'c9d8f5af25285738871dbbe911c4aa60080a4c05e7120bc752bdd273a2feaad2'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.14.0-dev.3.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.14.0-dev.3.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 'a829d7d390422f91959b24cb4188beb063f738ae046f0140469a3258b4662cb3'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.14.0-dev.3.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 'a0df4e38ab77651b52633656fd395007aebca9345cc148de4b296d0be2c6f203'
    end

    resource 'content_shell' do
      version '1.14.0-dev.3.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.14.0-dev.3.0/dartium/content_shell-macos-ia32-release.zip'
      sha256 '3048a88aec1ab7b806ffa294fc0cd6ef7c1a1c74c3cc7eedb637349949c89dd0'
    end

    resource 'dartium' do
      version '1.14.0-dev.3.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.14.0-dev.3.0/dartium/dartium-macos-ia32-release.zip'
      sha256 '52e9a7517c4232dc38ca377c3a0b96e52255afab12fabc99783e3304c8fe0074'
    end
  end

  resource 'content_shell' do
    version '1.13.0'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.13.0/dartium/content_shell-macos-ia32-release.zip'
    sha256 'a4bd5f450d810af17c5450a0c4f2dc252a88d9121328cc6d7aee26c4030d64a7'
  end

  resource 'dartium' do
    version '1.13.0'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.13.0/dartium/dartium-macos-ia32-release.zip'
    sha256 '37ba1112c85b19f1171057c24d3885a488dd5a950eb25c8c632744022b70c567'
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
      #!/bin/bash
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
