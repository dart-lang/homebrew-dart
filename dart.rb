require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.17.0'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.17.0/sdk/dartsdk-macos-x64-release.zip'
    sha256 '6dbddd856c9466320513fd1644690b18d4b1c382480e92a1c2185b33b77c22d4'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.17.0/sdk/dartsdk-macos-ia32-release.zip'
    sha256 '3729788dd37f9a2e96fdec0a2e8510c866eae2cf8f618a39ed33804baee17cfd'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.18.0-dev.0.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.18.0-dev.0.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 'f6ba6c91a3d00540d8d3ab4f2dc9cad859a043cb2bdb22097311385a27e21ced'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.18.0-dev.0.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '1502ae892ec1e0b2b4f575993b2a505a8ab5700248ab4ed3b818f7be278f6558'
    end

    resource 'content_shell' do
      version '1.18.0-dev.0.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.18.0-dev.0.0/dartium/content_shell-macos-ia32-release.zip'
      sha256 '5db036938034496a10ef21439b0ada9f7ec026361c27bb9a0c10188df3e9ae29'
    end

    resource 'dartium' do
      version '1.18.0-dev.0.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.18.0-dev.0.0/dartium/dartium-macos-ia32-release.zip'
      sha256 'be69ec4f0481edbf8bcf2681122917d609b2f653deaf49496dc11ba73cc150d0'
    end
  end

  resource 'content_shell' do
    version '1.17.0'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.17.0/dartium/content_shell-macos-ia32-release.zip'
    sha256 '8f951280d8194a2ae7aed5e965491a98b9022aab19310b6e9287e3d4fa958ed1'
  end

  resource 'dartium' do
    version '1.17.0'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.17.0/dartium/dartium-macos-ia32-release.zip'
    sha256 'a81f861bd56c5888c2aa223024d0610a86fc5931b184ab1e7f130d56a6aba279'
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
