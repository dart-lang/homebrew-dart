class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "1.24.0"
  if MacOS.prefer_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "a8569b0429333719204a7e42948fe411bf3523d50966890c15b2635a89f97a9a"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.0/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "2e26b3ae3387e8fc8497bd0343da2d7fbaf82f192b3da0a7d7e4583a252937f3"
  end

  devel do
    version "1.25.0-dev.0.0"
    if MacOS.prefer_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.25.0-dev.0.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "1128e4d108664307aaa92afb9557ead707bc6654ca33736ebc56f29806a43f0d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.25.0-dev.0.0/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "c47d0fc02fbf7a574d504b775a19baca2fa8fee9519889564bbd3e0a320aae05"
    end

    resource "content_shell" do
      version "1.25.0-dev.0.0"
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.25.0-dev.0.0/dartium/content_shell-macos-x64-release.zip"
      sha256 "d053cfa76a5968a8b52241c2458e3fe170933cd0825f29bf83b9362e1fe8d34f"
    end

    resource "dartium" do
      version "1.25.0-dev.0.0"
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/1.25.0-dev.0.0/dartium/dartium-macos-x64-release.zip"
      sha256 "ce5d638beb5fedaaa2e7b26b6d97c93ded6429c3095c112b3101c0f1d9b6e0a4"
    end
  end

  option "with-content-shell", "Download and install content_shell -- headless Dartium for testing"
  option "with-dartium", "Download and install Dartium -- Chromium with Dar"

  resource "content_shell" do
    version "1.24.0"
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.0/dartium/content_shell-macos-x64-release.zip"
    sha256 "b28eb004b268371fa4b3ca6f55c5be2936c1b91691f8d596e9967801d7a33b8e"
  end

  resource "dartium" do
    version "1.24.0"
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.0/dartium/dartium-macos-x64-release.zip"
    sha256 "20c3781e84be3e7acac68362c5be670aa989127599bd0fddb8a5e3f9965fc3b8"
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
