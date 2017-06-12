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
