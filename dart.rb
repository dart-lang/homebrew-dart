require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.15.0'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.15.0/sdk/dartsdk-macos-x64-release.zip'
    sha256 '612d484a848d29811d1ca40d9ebc23a17f05d24522ca204ace03d792fb8a9fdc'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.15.0/sdk/dartsdk-macos-ia32-release.zip'
    sha256 '20afb6f71fefa88a9747e9dfc35adeab01a03ce3c8d6b6c5b46fede9d9f40555'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.16.0-dev.5.5'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.16.0-dev.5.5/sdk/dartsdk-macos-x64-release.zip'
      sha256 '0324e5be0866e16ce1ba578e7843784af9f8b1d8e2b35da959e6dc26a0084b33'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.16.0-dev.5.5/sdk/dartsdk-macos-ia32-release.zip'
      sha256 'ea10e78a3f9bf2df4e5ab88d5c6b155ec1d254ea0e3467927317864ca1b08c7a'
    end

    resource 'content_shell' do
      version '1.16.0-dev.5.5'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.16.0-dev.5.5/dartium/content_shell-macos-ia32-release.zip'
      sha256 '4819d79a4dd3555ad659be719075a0a6638371b52f5e183de7eb6b18ee8f733d'
    end

    resource 'dartium' do
      version '1.16.0-dev.5.5'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.16.0-dev.5.5/dartium/dartium-macos-ia32-release.zip'
      sha256 'aae9af527303040c7bf0c67b92e0cb9fee9830bfaf08363e28e6907dcd24cab9'
    end
  end

  resource 'content_shell' do
    version '1.15.0'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.15.0/dartium/content_shell-macos-ia32-release.zip'
    sha256 'ebf05f2f0d5ea08d97beed9093687123cf7e39361e77bff1c678ec83e22fca58'
  end

  resource 'dartium' do
    version '1.15.0'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.15.0/dartium/dartium-macos-ia32-release.zip'
    sha256 '01ecca7f8dfd2aadcffb9f17ceb181f5f107a1583228f61959c438f2e63ad5f7'
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
