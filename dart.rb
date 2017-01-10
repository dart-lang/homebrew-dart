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
    version '1.22.0-dev.6.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.22.0-dev.6.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 '52c3374afb53a3e3d2d32025c072ebb0692e907ed6ce2e4970e984547492ddb8'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.22.0-dev.6.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '203b683ee80266814fc8766ab02212d182835dde42b2bd86a22b2f45773aca0f'
    end

    resource 'content_shell' do
      version '1.22.0-dev.6.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.22.0-dev.6.0/dartium/content_shell-macos-x64-release.zip'
      sha256 '363243a0d9cf32f27879a95f4acc27efea693a8b5498f44533bc3a0bbbf062e6'
    end

    resource 'dartium' do
      version '1.22.0-dev.6.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.22.0-dev.6.0/dartium/dartium-macos-x64-release.zip'
      sha256 '3b7a01bcf641a8ec12f1a27cd6aa962a654291f332b176399ac135327ac467c7'
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
