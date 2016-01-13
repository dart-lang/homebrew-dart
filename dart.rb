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
    version '1.14.0-dev.7.0'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.14.0-dev.7.0/sdk/dartsdk-macos-x64-release.zip'
      sha256 '7ae90e80b59543b5b458a5ab469f59df567cc13466267ec004cf81d6159fa896'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.14.0-dev.7.0/sdk/dartsdk-macos-ia32-release.zip'
      sha256 'b4bbbe10abd4b7a54beebe86799cb1c05350e36a59683a686931ce9f16a254fa'
    end

    resource 'content_shell' do
      version '1.14.0-dev.7.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.14.0-dev.7.0/dartium/content_shell-macos-ia32-release.zip'
      sha256 '690c13bdfb54b6f4f34476818e4d2545565fd15a43f2dc464bbe9b913c3729dc'
    end

    resource 'dartium' do
      version '1.14.0-dev.7.0'
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/1.14.0-dev.7.0/dartium/dartium-macos-ia32-release.zip'
      sha256 'e5273b6e1af5f7f50ea7fb02f02783338d00b57412ded3af219cec35986669fc'
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
