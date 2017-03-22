class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "1.22.1"
  if MacOS.prefer_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/1.22.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "76962c2455763b1dbba642056990929b4bebff804ba59cb7cf2863cb354bd20e"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/1.22.1/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "e176c8561ab0c56d817a0afe8a11593389fd232fad6b707d62f980673769e06f"
  end

  devel do
    version "1.23.0-dev.9.1"
    if MacOS.prefer_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.23.0-dev.9.1/sdk/dartsdk-macos-x64-release.zip"
      sha256 "c1db1b13fda530aebbcea2dca85bacf25378750767680ae18e054018e674aad2"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.23.0-dev.9.1/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "0a443df92710c429a35d312858dd5286bcdcf56eee60de0dbc22941c31064b5a"
    end

    resource "content_shell" do
      version "1.23.0-dev.9.1"
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.23.0-dev.9.1/dartium/content_shell-macos-x64-release.zip"
      sha256 "8f1f49507d413e88b511a64bf2fd7add68424b480347e616b5df2ad7557c1001"
    end

    resource "dartium" do
      version "1.23.0-dev.9.1"
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.23.0-dev.9.1/dartium/dartium-macos-x64-release.zip"
      sha256 "32dcf2a77f1f2cb2e834866d2c95e4af0b6b77ebbbe362a10f6caf0523b9a094"
    end
  end

  option "with-content-shell", "Download and install content_shell -- headless Dartium for testing"
  option "with-dartium", "Download and install Dartium -- Chromium with Dar"

  resource "content_shell" do
    version "1.22.1"
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/1.22.1/dartium/content_shell-macos-x64-release.zip"
    sha256 "ccd863992c795c67c815b4b95680d569df3de6f6af3cd17b5fe325d47b4d0e40"
  end

  resource "dartium" do
    version "1.22.1"
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/1.22.1/dartium/dartium-macos-x64-release.zip"
    sha256 "c31219bb75fd2126ae839ee7919aa3557be59b74afcb4c484ff95cd65e4a00a3"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]

    if build.with? "dartium"
      dartium_binary = "Chromium.app/Contents/MacOS/Chromium"
      prefix.install resource("dartium")
      (bin+"dartium").write shim_script dartium_binary
    end

    if build.with? "content-shell"
      content_shell_binary = "Content Shell.app/Contents/MacOS/Content Shell"
      prefix.install resource("content_shell")
      (bin+"content_shell").write shim_script content_shell_binary
    end
  end

  def shim_script(target)
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
    (testpath/"sample.dart").write <<-EOS.undent
      void main() {
        print(r"test message");
      }
    EOS

    assert_equal "test message\n", shell_output("#{bin}/dart sample.dart")
  end
end
