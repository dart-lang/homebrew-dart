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
    version '1.20.0-dev.10.3'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.20.0-dev.10.3/sdk/dartsdk-macos-x64-release.zip'
      sha256 '8b38cc2f23ce3003d69e87285eab3f1a95ee5f6576deca80a22ad0469c30a652'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.20.0-dev.10.3/sdk/dartsdk-macos-ia32-release.zip'
      sha256 'fa56a84d154fae850810b6d0adfe958ea0252e483453e3dea964e9511419d1c9'
    end

    resource 'content_shell' do
      version '1.20.0-dev.10.3'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.20.0-dev.10.3/dartium/content_shell-macos-x64-release.zip'
      sha256 '3ba26b243c0486ec99fb82dfe64094abbfbe11ef355f13e6bb05d805c306501f'
    end

    resource 'dartium' do
      version '1.20.0-dev.10.3'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.20.0-dev.10.3/dartium/dartium-macos-x64-release.zip'
      sha256 '11d9b1ca6d4756cfe3b5681d4ff88e56d96fd04a0a39286a060133b8a112030f'
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
