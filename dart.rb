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
    version "1.23.0-dev.11.5"
    if MacOS.prefer_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.23.0-dev.11.5/sdk/dartsdk-macos-x64-release.zip"
      sha256 "8f294c6f637fe11ee06bcebcb981cc3f737f2e3456eccc306bfea0dbc43d1e08"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.23.0-dev.11.5/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "8d1676e8d77ce24e0843d30d6602c737d8632ef51b3e8807e4cae83923ff8824"
    end

    resource "content_shell" do
      version "1.23.0-dev.11.5"
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.23.0-dev.11.5/dartium/content_shell-macos-x64-release.zip"
      sha256 "584f68bdfc734b477f6b1b73bfbc5e0a2dd71362cbf7bc76af347e346ee06c59"
    end

    resource "dartium" do
      version "1.23.0-dev.11.5"
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.23.0-dev.11.5/dartium/dartium-macos-x64-release.zip"
      sha256 "cfa479975cde55cd6eb56614bf14598da05556088ec96fbebf8a983393cbeac2"
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
