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
    version '1.16.0-dev.5.4'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.16.0-dev.5.4/sdk/dartsdk-macos-x64-release.zip'
      sha256 '46c8b5510f3a514a85703f1f2c6cee073cad7dd956814231548c78f797026878'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.16.0-dev.5.4/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '388fe236315567845bb9884318e136b9442a4783df2e0459f24fda2d6f4aa458'
    end

    resource 'content_shell' do
      version '1.16.0-dev.5.4'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.16.0-dev.5.4/dartium/content_shell-macos-ia32-release.zip'
      sha256 '782add73c061ec323ff9c581a7d57c6975f106f9f9a64af1ad6e9127d9de01c6'
    end

    resource 'dartium' do
      version '1.16.0-dev.5.4'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.16.0-dev.5.4/dartium/dartium-macos-ia32-release.zip'
      sha256 'd566f506adcbf72e82eb41b8cd67c7721539f7260e07b03e978b713d260e81aa'
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
