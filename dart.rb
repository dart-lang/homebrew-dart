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
    version "1.24.0-dev.6.6"
    if MacOS.prefer_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.24.0-dev.6.6/sdk/dartsdk-macos-x64-release.zip"
      sha256 "d229d12396a7e9ed279f9f9faac7f811fb44616e3dfd50033524153bb5b65083"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.24.0-dev.6.6/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "d749f89951c4d1c61377fba9a1d3c0de13d9cd18a1ee340a90f3c17e5e78115a"
    end

    resource "content_shell" do
      version "1.24.0-dev.6.6"
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.24.0-dev.6.6/dartium/content_shell-macos-x64-release.zip"
      sha256 "2e26ad5aceeed63358541b4b2ce950110242a69d187915401cbfaa021303d763"
    end

    resource "dartium" do
      version "1.24.0-dev.6.6"
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.24.0-dev.6.6/dartium/dartium-macos-x64-release.zip"
      sha256 "03590beda753175f7c6fd4c91ad715e9c19aa3c2f3964c4ce872fbf2ba55a0b6"
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
