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
    version '1.18.0-dev.4.3'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.18.0-dev.4.3/sdk/dartsdk-macos-x64-release.zip'
      sha256 'fabef22f7ea3ef9600ad23ac00beb883e231d38e1ca5d8daeac50bf708b29e47'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.18.0-dev.4.3/sdk/dartsdk-macos-ia32-release.zip'
      sha256 'a537ae664099303e23ce952263bbe6ecbc7cef84bbe84515f708d1b0e77a0dbd'
    end

    resource 'content_shell' do
      version '1.18.0-dev.4.3'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.18.0-dev.4.3/dartium/content_shell-macos-ia32-release.zip'
      sha256 'bb78489fcc7bfbc617ddd7611f6f02356e93801d09cb38d76ba72cafa90dc567'
    end

    resource 'dartium' do
      version '1.18.0-dev.4.3'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.18.0-dev.4.3/dartium/dartium-macos-ia32-release.zip'
      sha256 '51bda5c222abdff0459c4b6d53c9fdbda53c5406526c9eb84ea996eb4069176f'
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
