require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.12.0'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.12.0/sdk/dartsdk-macos-x64-release.zip'
    sha256 'b69d3412ca8498222f298329757e790ddacf21e9ea1639f8bf65430f62fa9b0e'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.12.0/sdk/dartsdk-macos-ia32-release.zip'
    sha256 '0db76eae0fa5893d84a911520f07339e0e77d2921da7fad12f79c36a2e759cd8'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.12.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 'b69d3412ca8498222f298329757e790ddacf21e9ea1639f8bf65430f62fa9b0e'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '0db76eae0fa5893d84a911520f07339e0e77d2921da7fad12f79c36a2e759cd8'
    end

    resource 'content_shell' do
      version '1.12.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0/dartium/content_shell-macos-ia32-release.zip'
      sha256 'bd21158c82cc43a1f3d23b9282db0f74d50ab830c8b4d0acc62aa0d6fdc46ca0'
    end

    resource 'dartium' do
      version '1.12.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.12.0/dartium/dartium-macos-ia32-release.zip'
      sha256 '39dad1369d2745f3fac0ebc7228d9c0a1e713667d66af283e59f5045a5452e4c'
    end
  end

  resource 'content_shell' do
    version '1.12.0'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.12.0/dartium/content_shell-macos-ia32-release.zip'
    sha256 'bd21158c82cc43a1f3d23b9282db0f74d50ab830c8b4d0acc62aa0d6fdc46ca0'
  end

  resource 'dartium' do
    version '1.12.0'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.12.0/dartium/dartium-macos-ia32-release.zip'
    sha256 '39dad1369d2745f3fac0ebc7228d9c0a1e713667d66af283e59f5045a5452e4c'
  end

  def install
    libexec.install Dir['*']
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,docgen,dart?*}"]

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
