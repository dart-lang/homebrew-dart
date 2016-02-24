require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.14.2'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.14.2/sdk/dartsdk-macos-x64-release.zip'
    sha256 'ac9bf2e4d2797a4fac75d1f92429beb546882fc2bcc9cc2b6a18bf68338486cb'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.14.2/sdk/dartsdk-macos-ia32-release.zip'
    sha256 '842e09cc09274858cc604ff482c5b99c99ccab8a5593be443b78179d69abb71f'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.15.0-dev.4.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.15.0-dev.4.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 '7b468c7e08ef5790d6fe24e288d83b33fab41edc7361f588cd0d2588ff994ff1'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.15.0-dev.4.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '84a8828bc2a87802521f4f4d785792fe43ecfa6576985b23d66b4201e7a91769'
    end

    resource 'content_shell' do
      version '1.15.0-dev.4.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.15.0-dev.4.0/dartium/content_shell-macos-ia32-release.zip'
      sha256 '8294514fc16c523df57241484d74c0313431a4cd3971c7f00692b58cbae060af'
    end

    resource 'dartium' do
      version '1.15.0-dev.4.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.15.0-dev.4.0/dartium/dartium-macos-ia32-release.zip'
      sha256 'e2d26c3cd03561c730ec699e41cb0337539acd6c858855771f737a1565db0036'
    end
  end

  resource 'content_shell' do
    version '1.14.2'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.14.2/dartium/content_shell-macos-ia32-release.zip'
    sha256 'aa55a0f78833a9787c6db2e8f6ee61d77bc89d0da113bb5817918078300f2b54'
  end

  resource 'dartium' do
    version '1.14.2'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.14.2/dartium/dartium-macos-ia32-release.zip'
    sha256 '0aba6e58e887b1c63923afda093af6e564a6ad36801cfd861da58615ccea568c'
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
