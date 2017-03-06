require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.22.1'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.22.1/sdk/dartsdk-macos-x64-release.zip'
    sha256 '76962c2455763b1dbba642056990929b4bebff804ba59cb7cf2863cb354bd20e'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.22.1/sdk/dartsdk-macos-ia32-release.zip'
    sha256 'e176c8561ab0c56d817a0afe8a11593389fd232fad6b707d62f980673769e06f'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.23.0-dev.4.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.23.0-dev.4.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 'bee578fb5fd06478304be45927876fc8d9887b6b385f2deb9596154a91073662'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.23.0-dev.4.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 'c4f563cdb39b5b023e33b874b8551a0b7116e7c78ee00eb489bd3169910de5e6'
    end

    resource 'content_shell' do
      version '1.23.0-dev.4.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.23.0-dev.4.0/dartium/content_shell-macos-x64-release.zip'
      sha256 '4d2a3ba8a2621cea0f1b9d33f55838ea5fce266b660fbb8c941c78607ae79947'
    end

    resource 'dartium' do
      version '1.23.0-dev.4.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.23.0-dev.4.0/dartium/dartium-macos-x64-release.zip'
      sha256 '430a97c143f8317b1642864d4d0eabe3b343b7281fa6337ccdc51f7ead01ecb1'
    end
  end

  resource 'content_shell' do
    version '1.22.1'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.22.1/dartium/content_shell-macos-x64-release.zip'
    sha256 'ccd863992c795c67c815b4b95680d569df3de6f6af3cd17b5fe325d47b4d0e40'
  end

  resource 'dartium' do
    version '1.22.1'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.22.1/dartium/dartium-macos-x64-release.zip'
    sha256 'c31219bb75fd2126ae839ee7919aa3557be59b74afcb4c484ff95cd65e4a00a3'
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
