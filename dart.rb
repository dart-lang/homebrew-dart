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
    version "1.24.0-dev.4.1"
    if MacOS.prefer_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.24.0-dev.4.1/sdk/dartsdk-macos-x64-release.zip"
      sha256 "35ef099847b0115457ac441dc1105cafd624072dea0641fdf48b4ef45ccfa90d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.24.0-dev.4.1/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "93a3601cddbc15feba49684e03c59191e784dfec5c7b18f4e8351c5e2f6f7609"
    end

    resource "content_shell" do
      version "1.24.0-dev.4.1"
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.24.0-dev.4.1/dartium/content_shell-macos-x64-release.zip"
      sha256 "838e8d89abc703272adced9a38d7a791f602627ee225576bfff7db5b35506add"
    end

    resource "dartium" do
      version "1.24.0-dev.4.1"
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.24.0-dev.4.1/dartium/dartium-macos-x64-release.zip"
      sha256 "6cae1d037082b277c0bff430b7147d99631bbd4b5305a2914228d9ae672d577f"
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
