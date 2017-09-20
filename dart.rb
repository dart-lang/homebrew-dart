class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "1.24.2"
  if MacOS.prefer_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "06215d2c7b51308dba4041bf2c110144947fc114c25c2bdffc4920f52f677e3b"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.2/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "a282902f2e6a1ab8772a619f209f396856bcd070724c1b65f9ce463eec891c27"
  end

  devel do
    version "2.0.0-dev.1.0"
    if MacOS.prefer_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.1.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "309aa4c574ddfad464bb9eb2c0e4541fafe0dddae7de42a395566237b1211de2"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.1.0/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "36cd6f08d17673320d6d60ef8ff90fa27e93ed93d5bfa3673260acd5e09ab9c5"
    end
  end

  option "with-content-shell", "Download and install content_shell -- headless Dartium for testing"
  option "with-dartium", "Download and install Dartium -- Chromium with Dart"

  resource "content_shell" do
    version "1.24.2"
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.2/dartium/content_shell-macos-x64-release.zip"
    sha256 "01efc473c68aed830307d1dafb0cbcbfe77f40ceeeab3ef3ebe58a9912d05b13"
  end

  resource "dartium" do
    version "1.24.2"
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.2/dartium/dartium-macos-x64-release.zip"
    sha256 "188a038bd6367fddb434338bf6549bae25f5ad89b2f5b462acf8fb1fa20a3916"
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
