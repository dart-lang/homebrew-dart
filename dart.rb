require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.22.0'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.22.0/sdk/dartsdk-macos-x64-release.zip'
    sha256 '6f5e3ddfa32666f72392b985b78a7ccc8c507285c6d9ce59bdadd58de45ef343'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.22.0/sdk/dartsdk-macos-ia32-release.zip'
    sha256 '57a233b20ad21492b5ee417b9c0abc0eda1aa021272d211995e8e949dea8ac79'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.23.0-dev.1.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.23.0-dev.1.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 'c6323d2d34c5a44b2339a9d08859b9857f0ef81786d5bd7e595c485cef567920'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.23.0-dev.1.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '3a02a50d1c9bf4e0f938c44ba49bd60945192f654a203ff787aaf44e665de7aa'
    end

    resource 'content_shell' do
      version '1.23.0-dev.1.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.23.0-dev.1.0/dartium/content_shell-macos-x64-release.zip'
      sha256 '4152a4ae75cbdd8ead7e0c87886cdbb4648e250b57607acafcfce9389cdc8fb2'
    end

    resource 'dartium' do
      version '1.23.0-dev.1.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.23.0-dev.1.0/dartium/dartium-macos-x64-release.zip'
      sha256 'cecf28eaa8b548eae608bf8a845529c9da32dfae96f4614cb5f5379b84f7e61f'
    end
  end

  resource 'content_shell' do
    version '1.22.0'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.22.0/dartium/content_shell-macos-x64-release.zip'
    sha256 '1822328a4e039098c117494fa76c630b5aa958e4b5255c1e5af3a4b91d7b1c13'
  end

  resource 'dartium' do
    version '1.22.0'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.22.0/dartium/dartium-macos-x64-release.zip'
    sha256 'ea35026f6e8ccbedd73acd04943e0d417ed36d054a24ee00549ee89a3a1cff7f'
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
