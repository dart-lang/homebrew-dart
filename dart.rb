require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.21.0'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.21.0/sdk/dartsdk-macos-x64-release.zip'
    sha256 '90f9f2bb119b0b6c66d1262571134b876043a6ed53de0235516b569fd063c192'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.21.0/sdk/dartsdk-macos-ia32-release.zip'
    sha256 '6f9438b4f3d7f0d19a2358e34480ccf403a3f62556a79516301080ebb113ca8a'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.22.0-dev.1.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.22.0-dev.1.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 '6e4ae172e59f7704679654ec817915cf2fd1bba4624d9618cf4abf038b439d3d'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.22.0-dev.1.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '21175d5f88b5ae7cc6005e850c68c4ed7798e747f1226dbb8f8814cb255edf36'
    end

    resource 'content_shell' do
      version '1.22.0-dev.1.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.22.0-dev.1.0/dartium/content_shell-macos-x64-release.zip'
      sha256 'c4d5ad4801dc929e357afa7d97691c6903b99200e36cd0735bf5925ec53453f3'
    end

    resource 'dartium' do
      version '1.22.0-dev.1.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.22.0-dev.1.0/dartium/dartium-macos-x64-release.zip'
      sha256 '47ac1b0c010b597e1551d43e69b46ba0060610a6a36c39223a5f7f4517718fe1'
    end
  end

  resource 'content_shell' do
    version '1.21.0'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.21.0/dartium/content_shell-macos-x64-release.zip'
    sha256 '080b6df396e9b82e25daa52770db07baa75a32a4f88090b4bf1d14f69ab16905'
  end

  resource 'dartium' do
    version '1.21.0'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.21.0/dartium/dartium-macos-x64-release.zip'
    sha256 '97a7adf5c4c291fdf020613392455766ac30d2de139c8d3334e001a7cfc44084'
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
