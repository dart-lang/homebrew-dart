require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.11.3'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.11.3/sdk/dartsdk-macos-x64-release.zip'
    sha256 'd938cf2a6c27d0eb3f3827048083dfd54ce231d4369c33324e8f26701eae2970'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.11.3/sdk/dartsdk-macos-ia32-release.zip'
    sha256 'ad933e15b5a172aabd464e20b8a05873daad63f1cb1451d156247b6f9c3e1cff'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.12.0-dev.5.4'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0-dev.5.4/sdk/dartsdk-macos-x64-release.zip'
      sha256 '165c85938a5f856c756a182cbca30749bd2969e177db25ba732cd1b3ee4c6aee'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0-dev.5.4/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '1d8eff23947fc914acf4853f89a3b32258401c2f5fbad828ff556296f6e8094b'
    end

    resource 'content_shell' do
      version '1.12.0-dev.5.4'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0-dev.5.4/dartium/content_shell-macos-ia32-release.zip'
      sha256 'af43a95a891221eb158ffd04c149db1b54b1ede001d14b68a020f61fedae8ada'
    end

    resource 'dartium' do
      version '1.12.0-dev.5.4'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0-dev.5.4/dartium/dartium-macos-ia32-release.zip'
      sha256 '1362a31e932283bc7d6708819b1cec180d2c81ce39a2606b752446beb2cdedaa'
    end
  end

  resource 'content_shell' do
    version '1.11.3'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.11.3/dartium/content_shell-macos-ia32-release.zip'
    sha256 '04199ec06dd3dc94ef219f1817a34cf6f4c9ec7650bd1f597fb5155ebd9abe94'
  end

  resource 'dartium' do
    version '1.11.3'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.11.3/dartium/dartium-macos-ia32-release.zip'
    sha256 '10e14ccfcda7d70f82050795371f89c30e756d3bf53b113a9b869212ac76b03e'
  end

  def install
    libexec.install Dir['*']
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,docgen,dart?*}"]

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
