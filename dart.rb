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
    version '1.13.0-dev.7.5'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.13.0-dev.7.5/sdk/dartsdk-macos-x64-release.zip'
      sha256 '6b0dfa014ca2b2672ab3d41fcf5a015bef47c8416f0b879460823c94f5a76f05'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.13.0-dev.7.5/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '7deb37e0a1554ba83e7abc0dfc14c781de7ad63a30a2e7f3c5e1f07701271775'
    end

    resource 'content_shell' do
      version '1.13.0-dev.7.5'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.13.0-dev.7.5/dartium/content_shell-macos-ia32-release.zip'
      sha256 '2e466c8ba7f260835dea22788f5f67d2452c5729ffd5da06cce81ff85c1e167c'
    end

    resource 'dartium' do
      version '1.13.0-dev.7.5'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.13.0-dev.7.5/dartium/dartium-macos-ia32-release.zip'
      sha256 '1bdd5d4f4dcb505c2af7e19edc7c183b4e7020c3dfbb2a145d801761b548d500'
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
