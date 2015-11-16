require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.12.2'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.12.2/sdk/dartsdk-macos-x64-release.zip'
    sha256 'c14559d3e652fbde8b5ff099ae41501be47cf57db58a990c6be269a5be056f8a'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.12.2/sdk/dartsdk-macos-ia32-release.zip'
    sha256 'ed371027c4420eabc7af10de34d4b6d7e03a6739bab13809f3453f8f82ea9dac'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.13.0-dev.7.12'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.13.0-dev.7.12/sdk/dartsdk-macos-x64-release.zip'
      sha256 '2d91cd8cd1225e2f825291378189dc9425682efd852f694cba7972335118f509'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.13.0-dev.7.12/sdk/dartsdk-macos-ia32-release.zip'
      sha256 'ff5901a54030898035906d9a9149ee7526e51a775dfbfcacf2f47ae6844227e6'
    end

    resource 'content_shell' do
      version '1.13.0-dev.7.12'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.13.0-dev.7.12/dartium/content_shell-macos-ia32-release.zip'
      sha256 '9bfc75e711e12c1c440f728c1ef8070e28fe0e42a3b2fe482c7aa665f009c99f'
    end

    resource 'dartium' do
      version '1.13.0-dev.7.12'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.13.0-dev.7.12/dartium/dartium-macos-ia32-release.zip'
      sha256 '4adf90bf811d0b75c148c75f41ecb6f2eaf2cfe6bbf569ebde77a3e51872213a'
    end
  end

  resource 'content_shell' do
    version '1.12.2'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.12.2/dartium/content_shell-macos-ia32-release.zip'
    sha256 'c953dcf242ef151580f7442b4c52b72f132446b8a83e808576a6e3417cd07d77'
  end

  resource 'dartium' do
    version '1.12.2'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.12.2/dartium/dartium-macos-ia32-release.zip'
    sha256 'a7f875844c269480609660b4a34ced034c6917e7c0d82576f99ec2b398e04224'
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
