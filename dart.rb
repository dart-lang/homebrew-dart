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
    version '1.12.0-dev.2.2'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0-dev.2.2/sdk/dartsdk-macos-x64-release.zip'
      sha256 '31411a63ee6250167e08067ab9887e173469f4bff5a0f97ab3386e2b1f08ff97'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0-dev.2.2/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '5d7ec40ff26cb4ff31f7756715d20a536dce53590990c1b22009f5b5122d5100'
    end

    resource 'content_shell' do
      version '1.12.0-dev.2.2'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0-dev.2.2/dartium/content_shell-macos-ia32-release.zip'
      sha256 'f68f2ffc1535410cb6c043a7f68598fd0d2f1772c31e7f5937f303796d1ffb23'
    end

    resource 'dartium' do
      version '1.12.0-dev.2.2'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0-dev.2.2/dartium/dartium-macos-ia32-release.zip'
      sha256 '94d9cae09a93188e3725042fa09175423d5e7bc886b6553eb14e59978f182b3d'
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
