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
    version '1.22.0-dev.3.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.22.0-dev.3.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 'bdbb39cadb17aeedf73d8a68666488e12afdc796d5701e5bf1bae3e08f8b8a39'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.22.0-dev.3.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 'b63e1f46d6ebb1be3119598e93dcc14179964a43f42c68661bc441bd09aa001d'
    end

    resource 'content_shell' do
      version '1.22.0-dev.3.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.22.0-dev.3.0/dartium/content_shell-macos-x64-release.zip'
      sha256 'ee5768d716284506474190d3d392f328d83981ddba5d9102291c2b72de4f73ae'
    end

    resource 'dartium' do
      version '1.22.0-dev.3.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.22.0-dev.3.0/dartium/dartium-macos-x64-release.zip'
      sha256 '3654b120afdc9f279b9cdd84d11aeef5e454e4e242b5ff4a3a9c64d5b74ba4d3'
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
