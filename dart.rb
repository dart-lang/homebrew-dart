require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.20.1'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.20.1/sdk/dartsdk-macos-x64-release.zip'
    sha256 '7be95b4038d0f63dad006119e79cd49092244e42f5fdfde4c7e7004e44eae9c0'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.20.1/sdk/dartsdk-macos-ia32-release.zip'
    sha256 '39a4a5f939988b9a1ae62e6f56ba3a40e4f3cd076dcaf68ccd0b40d4a1f84561'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.21.0-dev.7.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.21.0-dev.7.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 'f0161d6e25441fd3f1897bd017fa0d74913a752aa2e998453964245c6e8b6c52'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.21.0-dev.7.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 'ffae879a41fb9923b711ef0c7311396bfa2dec8973a5d977d3504f9f2b8f6617'
    end

    resource 'content_shell' do
      version '1.21.0-dev.7.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.21.0-dev.7.0/dartium/content_shell-macos-x64-release.zip'
      sha256 'dd7a77c6308f671604510b3d781abd1e88a582324a3759350c02b43ae59e87fd'
    end

    resource 'dartium' do
      version '1.21.0-dev.7.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.21.0-dev.7.0/dartium/dartium-macos-x64-release.zip'
      sha256 '53fd06f649ef43dd166da4963a46a1f84425c5a4131254aa20a587437d6f0020'
    end
  end

  resource 'content_shell' do
    version '1.20.1'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.20.1/dartium/content_shell-macos-x64-release.zip'
    sha256 'a45f7bf0456ed8f4defb10cf5f35a7ed806fa2b3860c99dfd04d87885d28b165'
  end

  resource 'dartium' do
    version '1.20.1'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.20.1/dartium/dartium-macos-x64-release.zip'
    sha256 'c35a4ecda5ff81fb5557a7161350f1fa630d80eb42f8ad94f8a17e1fad6b0fe3'
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
