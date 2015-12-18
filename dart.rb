require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.13.1'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.13.1/sdk/dartsdk-macos-x64-release.zip'
    sha256 '63dccbb968a49bc7a46f17d7f77110dcdc1a60c3b82d8ada018be401081ac8df'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.13.1/sdk/dartsdk-macos-ia32-release.zip'
    sha256 'a862d17d67911d244ae74018c518abba2c6245333329a9c4d93a7589005f5269'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.14.0-dev.5.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.14.0-dev.5.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 '270683c530221899feff18a3e8629f889a280ded02eced1ae69e1ad051ce596b'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.14.0-dev.5.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '7e24156a480d6064a569c478cafa396807992d6fd9d1c056bc52472debdddcc3'
    end

    resource 'content_shell' do
      version '1.14.0-dev.5.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.14.0-dev.5.0/dartium/content_shell-macos-ia32-release.zip'
      sha256 '11d6fc5831b7525f9ebe621d099922c6192007d3082f2632fa08722ba1cd05fb'
    end

    resource 'dartium' do
      version '1.14.0-dev.5.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.14.0-dev.5.0/dartium/dartium-macos-ia32-release.zip'
      sha256 '4516498709567f354789105df5ea779f9e4539ad87aacc35b742cf8db58669d9'
    end
  end

  resource 'content_shell' do
    version '1.13.1'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.13.1/dartium/content_shell-macos-ia32-release.zip'
    sha256 '24bef8bf43732198644ce907b3a76f9801aed3165be5895d9269ae65321274c5'
  end

  resource 'dartium' do
    version '1.13.1'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.13.1/dartium/dartium-macos-ia32-release.zip'
    sha256 '0b5162ba457aa0c2db33795c93898570cec369cfb168dfb61f8ea3465a48ed99'
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
