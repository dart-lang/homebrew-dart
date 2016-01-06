require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.13.2'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.13.2/sdk/dartsdk-macos-x64-release.zip'
    sha256 'dbc5dc0d3cd75ba1288d8e588b0c2ae3cb7c49fa8abf864c710820115716e4a3'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.13.2/sdk/dartsdk-macos-ia32-release.zip'
    sha256 '83fb1393736f61ce2f2a399d378e7fac42955d62730bb1755a220f772f80af0a'
  end

  option 'with-content-shell', 'Download and install content_shell -- headless Dartium for testing'
  option 'with-dartium', 'Download and install Dartium -- Chromium with Dart'

  devel do
    version '1.14.0-dev.6.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.14.0-dev.6.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 '5afa8382a3a9c2d540867461ca73d76e3eaac332055cc2f770ac3a87ad368183'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.14.0-dev.6.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '3d7426f2369ce65c353e4d56b6a1ee6348befd1f0b7e79508450f5090cf4a2be'
    end

    resource 'content_shell' do
      version '1.14.0-dev.6.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.14.0-dev.6.0/dartium/content_shell-macos-ia32-release.zip'
      sha256 'b16aa6db215922e6fd60fa7c68329aef7f27732d6cba67c6d77e94dc7c0a5897'
    end

    resource 'dartium' do
      version '1.14.0-dev.6.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.14.0-dev.6.0/dartium/dartium-macos-ia32-release.zip'
      sha256 '1f868868fd66502afb62fa950203e8cbbff0b528f6b7a19f0c8e1e585bbb1784'
    end
  end

  resource 'content_shell' do
    version '1.13.2'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.13.2/dartium/content_shell-macos-ia32-release.zip'
    sha256 'f54a008fcb32a2c8179d3566127bfe8e220769c4c7368bdf4b3b62ed914bec84'
  end

  resource 'dartium' do
    version '1.13.2'
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.13.2/dartium/dartium-macos-ia32-release.zip'
    sha256 'b620003c3ef4bbe2771490f9d5f009a7473b1bb39b5fcd41d45666184c7965ef'
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
