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
    version '1.14.0-dev.1.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.14.0-dev.1.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 '2233322e818bbedc7caf91e8b691eef12d15cd788b021d36f808a5ec2ce723db'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.14.0-dev.1.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '9eb3b36de329daad182dcecbae8102aca1295f481dc4aa738a8bcbe203e65fbc'
    end

    resource 'content_shell' do
      version '1.14.0-dev.1.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.14.0-dev.1.0/dartium/content_shell-macos-ia32-release.zip'
      sha256 'e8a64b51ace9638153b8f9e5da7d92042e61fc2827e6b907fb2f6dfd5ad04ee0'
    end

    resource 'dartium' do
      version '1.14.0-dev.1.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.14.0-dev.1.0/dartium/dartium-macos-ia32-release.zip'
      sha256 '6a2b1dcf69685c4242caadf86edd08a8a8e0a982ddaa5bd4a6eeed84a60da826'
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
