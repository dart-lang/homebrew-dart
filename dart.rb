require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.17.1'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.17.1/sdk/dartsdk-macos-x64-release.zip'
    sha256 'a12fba33300e4b3b93e2a462818a0a5c9fbc94a48e5a655dfbc6a3078d9c5f17'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.17.1/sdk/dartsdk-macos-ia32-release.zip'
    sha256 'aff0c8d3b4b0dde087ceb12c2bb4ff636612effbf072a6fb0e6321f682b98d76'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.18.0-dev.0.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.18.0-dev.0.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 'f6ba6c91a3d00540d8d3ab4f2dc9cad859a043cb2bdb22097311385a27e21ced'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.18.0-dev.0.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '1502ae892ec1e0b2b4f575993b2a505a8ab5700248ab4ed3b818f7be278f6558'
    end

    resource 'content_shell' do
      version '1.18.0-dev.0.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.18.0-dev.0.0/dartium/content_shell-macos-ia32-release.zip'
      sha256 '5db036938034496a10ef21439b0ada9f7ec026361c27bb9a0c10188df3e9ae29'
    end

    resource 'dartium' do
      version '1.18.0-dev.0.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.18.0-dev.0.0/dartium/dartium-macos-ia32-release.zip'
      sha256 'be69ec4f0481edbf8bcf2681122917d609b2f653deaf49496dc11ba73cc150d0'
    end
  end

  resource 'content_shell' do
    version '1.17.1'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.17.1/dartium/content_shell-macos-ia32-release.zip'
    sha256 'adae72c29e34f2bcca1abd6700761f71d7bcd94ed4b44093ae05beeb4b1e8c83'
  end

  resource 'dartium' do
    version '1.17.1'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.17.1/dartium/dartium-macos-ia32-release.zip'
    sha256 'b9210407d2432f6e11c6f39eb654ff90a9c85b47afd11600a07af6be8efe8d6e'
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
