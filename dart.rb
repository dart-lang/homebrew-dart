require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.18.0'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.18.0/sdk/dartsdk-macos-x64-release.zip'
    sha256 '8ca53818d7b4a15d7247623243245d8a092642d3014b1c66e34db175e9ccc0a4'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.18.0/sdk/dartsdk-macos-ia32-release.zip'
    sha256 '0db92f4465494d1e6d9b23d11bd241691bcd396ce2965a4c97490f6d5b99897d'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.19.0-dev.0.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.19.0-dev.0.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 '84aef776e318ebff240de9eb76fbac126de41f29c7345dced4b7dccb5263caf0'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.19.0-dev.0.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 'c9fe7378d0175f879228e08c7b233c47a96cf9e4194e6308611c33354dad6432'
    end

    resource 'content_shell' do
      version '1.19.0-dev.0.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.19.0-dev.0.0/dartium/content_shell-macos-ia32-release.zip'
      sha256 '4f7a52490edcee0604f6f27ec77a5501677f8400e602c94b992aa846dca68b9a'
    end

    resource 'dartium' do
      version '1.19.0-dev.0.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.19.0-dev.0.0/dartium/dartium-macos-ia32-release.zip'
      sha256 '3766b40a82be551b9be0a4bb5fe3cf6aa00427a6e535c4d15e166d547672b503'
    end
  end

  resource 'content_shell' do
    version '1.18.0'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.18.0/dartium/content_shell-macos-ia32-release.zip'
    sha256 '320c711e09631a75b3d5c68eb83d5abf5435ce60dc1894b805d9c6ba75e42cb3'
  end

  resource 'dartium' do
    version '1.18.0'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.18.0/dartium/dartium-macos-ia32-release.zip'
    sha256 '66d0d3e51579cd422396b1c14a4afaa9f9db0549453f482311d42c51400b9373'
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
