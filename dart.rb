class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "1.24.1"
  if MacOS.prefer_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "a898da785c83bf9074d50d9395e9f21acd91d18fa7c13c2735ffb4bbbe777e9a"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.1/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "f18ead7f313072c1ea91ff77ba6f4e94a04a7f252e7696b9b8a2905380656981"
  end

  devel do
    version "1.25.0-dev.2.0"
    if MacOS.prefer_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.25.0-dev.2.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "78ceca2493fdf321039fa50c22094cd7672737106f35c27f5a8d3968c5d4af74"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.25.0-dev.2.0/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "5cbbea0a07cb11af9649cd58d3d966221e1226d24494882d6703ead2f443d824"
    end

    resource "content_shell" do
      version "1.25.0-dev.2.0"
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.25.0-dev.2.0/dartium/content_shell-macos-x64-release.zip"
      sha256 "55386a1205bd8e21746b5201431fed67fe69db64614a76395d147777d1c308e5"
    end

    resource "dartium" do
      version "1.25.0-dev.2.0"
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.25.0-dev.2.0/dartium/dartium-macos-x64-release.zip"
      sha256 "b6d78efac2b4d3ab2eddf5d0e72b846de4691b1b0a0af16333a4c00740b15864"
    end
  end

  option "with-content-shell", "Download and install content_shell -- headless Dartium for testing"
  option "with-dartium", "Download and install Dartium -- Chromium with Dar"

  resource "content_shell" do
    version "1.24.1"
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.1/dartium/content_shell-macos-x64-release.zip"
    sha256 "626cbc081378597a3f292fb524887e1a0cd8f705b896ec285c0ef792dbaab83f"
  end

  resource "dartium" do
    version "1.24.1"
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.1/dartium/dartium-macos-x64-release.zip"
    sha256 "59c0e77abfecb444aecc31df7ddf01669814973c19be3f55c0afa4da87bd8a8b"
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
