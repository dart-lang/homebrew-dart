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
    version '1.12.0-dev.1.1'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0-dev.1.1/sdk/dartsdk-macos-x64-release.zip'
      sha256 '2a9b7ce689366026989fe91e3139cf6a2fbc7183dfcfd4f5b75a1fbb434aee5f'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0-dev.1.1/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '4f2ffeec3dce70b5013c5288c126a09cd44ae05c609204351e196edea5b13fbe'
    end

    resource 'content_shell' do
      version '1.12.0-dev.1.1'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0-dev.1.1/dartium/content_shell-macos-ia32-release.zip'
      sha256 '4b7308ca319b336a25e408f1e7cd59da6874d24f33a411b984b425e5eacf9f10'
    end

    resource 'dartium' do
      version '1.12.0-dev.1.1'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0-dev.1.1/dartium/dartium-macos-ia32-release.zip'
      sha256 '74a81c6b135715f7bb6eb25170377e6b305463685d5e5cc3aa2b9f33e0a459bd'
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
