require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.14.0'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.14.0/sdk/dartsdk-macos-x64-release.zip'
    sha256 '4248c2cde510969aba849855d605f31fd9dec4de06bf41a011c7fec43fd08dea'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.14.0/sdk/dartsdk-macos-ia32-release.zip'
    sha256 'a455bb4806e6765055297b13cdeab21874f767f573cd4c5729ab477f4e03e846'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.15.0-dev.0.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.15.0-dev.0.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 'dec04f1fdef6dd53ab0407eb5eb69d45b5ef0e08f0aaeb7dba6b5d1ec9aa9b20'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.15.0-dev.0.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '2187836512914bf44c73eb69373f8a951c5215a1c55f8a6b1b07276a8b52068d'
    end

    resource 'content_shell' do
      version '1.15.0-dev.0.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.15.0-dev.0.0/dartium/content_shell-macos-ia32-release.zip'
      sha256 'b296f12b984fe58ca6e367973aeb99093e6bf6600ba5bbd064f3750bd3b07dfa'
    end

    resource 'dartium' do
      version '1.15.0-dev.0.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.15.0-dev.0.0/dartium/dartium-macos-ia32-release.zip'
      sha256 'e47a0d4a53238aee411d770a86b85d08959d4153f53ba46e4fab5e03da08b000'
    end
  end

  resource 'content_shell' do
    version '1.14.0'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.14.0/dartium/content_shell-macos-ia32-release.zip'
    sha256 '128a6c4e1cdaf4c5699fc149aa88ef7ad79fb091c2627286083a969d5632faf2'
  end

  resource 'dartium' do
    version '1.14.0'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.14.0/dartium/dartium-macos-ia32-release.zip'
    sha256 'e12fc82a2fb03ffcd1799f490e2e8fbae2e4f5a270e348cd206f8f2681c54e79'
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
