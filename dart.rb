require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.16.1'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.16.1/sdk/dartsdk-macos-x64-release.zip'
    sha256 'b15a637c7addb8835c4961831c2c58276b179acf03bbfdde37821037067f39aa'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.16.1/sdk/dartsdk-macos-ia32-release.zip'
    sha256 '1acd27efc1195a9627fd41f8e9dbf5fde87dbf7f50afb473c172fecbaaef5be8'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.17.0-dev.6.4'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.17.0-dev.6.4/sdk/dartsdk-macos-x64-release.zip'
      sha256 'dbf9e2a118b9b1d91c3f57fb1024d784644d4061c6d96ab4276ebbbe88ac555c'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.17.0-dev.6.4/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '54b3e2738788838e7b17e767ba1411d912d9a3af715471c9cab3436b1893e932'
    end

    resource 'content_shell' do
      version '1.17.0-dev.6.4'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.17.0-dev.6.4/dartium/content_shell-macos-ia32-release.zip'
      sha256 'eb895b43c808d7f151afcf8334042f6862e02c9ac0f9bb89233ed33e06a4b93c'
    end

    resource 'dartium' do
      version '1.17.0-dev.6.4'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.17.0-dev.6.4/dartium/dartium-macos-ia32-release.zip'
      sha256 'ceb698e3b97cf125d2734cc348d3bbc3df4d6ea9f5ce95fd5360d76de862cf8e'
    end
  end

  resource 'content_shell' do
    version '1.16.1'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.16.1/dartium/content_shell-macos-ia32-release.zip'
    sha256 '329b3fbd0728bcf54efc7517194c0acddd92c76f3054edeba4907eda577c0ebc'
  end

  resource 'dartium' do
    version '1.16.1'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.16.1/dartium/dartium-macos-ia32-release.zip'
    sha256 '52e0aeae1ba78cba041444969311f62af7f153893de89fc2ca96a3e627434caa'
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
