class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "1.23.0"
  if MacOS.prefer_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/1.23.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c5557ae30a0783ed6fa790efe2ea9bbc0754def04a0d31ea9a1be7d89743395d"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/1.23.0/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "ebc1ae140965ec8f11d523e248444dc9ea1a300c449a782785a5aa55d1af5d75"
  end

  devel do
    version "1.24.0-dev.6.9"
    if MacOS.prefer_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.24.0-dev.6.9/sdk/dartsdk-macos-x64-release.zip"
      sha256 "9da940c77e2e99f72d4382ad942f1026901b0768fc590b289deb9c74b484ee98"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.24.0-dev.6.9/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "699b7cb7ae14efbcf4a635139e56999d1461cc8f3d7b4f5ab96baea0b881713f"
    end

    resource "content_shell" do
      version "1.24.0-dev.6.9"
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.24.0-dev.6.9/dartium/content_shell-macos-x64-release.zip"
      sha256 "e442329ae6c3154d2a04e37de7fa251168df54cbbb332f2b51e3018b805006dd"
    end

    resource "dartium" do
      version "1.24.0-dev.6.9"
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.24.0-dev.6.9/dartium/dartium-macos-x64-release.zip"
      sha256 "5eb70d91d21c281389c5c31bda4f642bc5e5a21c84732910a46a8991a15fc0fb"
    end
  end

  option "with-content-shell", "Download and install content_shell -- headless Dartium for testing"
  option "with-dartium", "Download and install Dartium -- Chromium with Dar"

  resource "content_shell" do
    version "1.23.0"
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/1.23.0/dartium/content_shell-macos-x64-release.zip"
    sha256 "e1144fe2b16d18288f08300e0a68f2c58aee6f5fe6f2f7e62d9dcc684a05100b"
  end

  resource "dartium" do
    version "1.23.0"
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/1.23.0/dartium/dartium-macos-x64-release.zip"
    sha256 "19c3f84e5ef3e0e75abee42027152b76038ba540212677bdb35d5756e9de7cff"
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
