require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.11.1'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.11.1/sdk/dartsdk-macos-x64-release.zip'
    sha256 'ad81ce3a2d13052dfc2b31681eebcdf39c0f11a94da2187c4c9231f3714a4e70'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.11.1/sdk/dartsdk-macos-ia32-release.zip'
    sha256 'f010c1090f0a5b1c857c78e84c9f8e6fb5e519ba73a2f4816330af07cdafc1f4'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.12.0-dev.4.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0-dev.4.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 '9da6354574e3b8d5139f7ca16ae1ac8320266813da7d0a97eb1ddb4bc0737f84'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0-dev.4.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '58256339f8d8d4c8293145e8420e57b43842f23f4f1704da0bac04691588657c'
    end

    resource 'content_shell' do
      version '1.12.0-dev.4.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0-dev.4.0/dartium/content_shell-macos-ia32-release.zip'
      sha256 '11ce03ae2d6f6b7d479e2ce732b3ce0942a8a49c9888f18b55d0331e97f2345b'
    end

    resource 'dartium' do
      version '1.12.0-dev.4.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0-dev.4.0/dartium/dartium-macos-ia32-release.zip'
      sha256 'fd5631759129696eb5d01ee6675bdeab1eab6144967327e2633e4442e88d5842'
    end
  end

  resource 'content_shell' do
    version '1.11.1'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.11.1/dartium/content_shell-macos-ia32-release.zip'
    sha256 'cbde87a5becb2ca4c8256e624a2eab6943df26f58125cb2b65cc38496c15f3a9'
  end

  resource 'dartium' do
    version '1.11.1'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.11.1/dartium/dartium-macos-ia32-release.zip'
    sha256 '795fb4fd1681071cda62c69713f1be505270c6fde75964ea025fb39457a0434f'
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
