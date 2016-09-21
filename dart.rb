require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.19.1'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.19.1/sdk/dartsdk-macos-x64-release.zip'
    sha256 'bbcbf5a6c566b3a1a057129158982f4fba54c848e0c3ed4fcee7fdf85d53d885'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.19.1/sdk/dartsdk-macos-ia32-release.zip'
    sha256 'ff28e48fff2b8da23b52a7abf8c4dd81548ad2fd4582d7bcf40eb57bcccaa39a'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.20.0-dev.7.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.20.0-dev.7.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 '2b10c759379a7b0e2556e8b73feced7fbf7101f802b21f97bc26ed03bc36ac0c'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.20.0-dev.7.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 'a8060285040feec0d45f517bf1c9e6c14b4d01ccf5b15808b1eb422ad8c48e48'
    end

    resource 'content_shell' do
      version '1.20.0-dev.7.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.20.0-dev.7.0/dartium/content_shell-macos-x64-release.zip'
      sha256 'ec441a703f4fd2a3ac394f6bbbb210852f5d30318ed8c7da76ef00ecbf9733b8'
    end

    resource 'dartium' do
      version '1.20.0-dev.7.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.20.0-dev.7.0/dartium/dartium-macos-x64-release.zip'
      sha256 '23ad804716ef1370669af3a5a3f67bfd0153eef8090bb2047e6b3cd0fd3835c9'
    end
  end

  resource 'content_shell' do
    version '1.19.1'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.19.1/dartium/content_shell-macos-x64-release.zip'
    sha256 '6ad4520bdf5a3034ebf63aec915a5a883b5806c6949f9e42d5da486651a50fc1'
  end

  resource 'dartium' do
    version '1.19.1'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.19.1/dartium/dartium-macos-x64-release.zip'
    sha256 'e7861c2228a82b95524f3dd4ac32ca0d862fd11ba6fee8458bd549eb8cdf2fcc'
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
