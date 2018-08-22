class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "2.0.0"
  if MacOS.prefer_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.0.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "7cb9e65cea94ce23b05af4e5224ec416b26c3fb6bf0718778b68f6a73e617cc3"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.0.0/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "da55f8fce70ca46e97304810406c89f039464be909b9b92f13986ce918da6775"
  end

  devel do
    version "2.1.0-dev.2.0"
    if MacOS.prefer_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.1.0-dev.2.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "ba883eb1c78e8b303bec67163c2e92a0a9377eb8908e2f8b0c34b0cae78dcd8a"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.1.0-dev.2.0/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "7317e9169d6b51414116ee03a0c8249d942658f94da63c3cb0c13bda6ae6d75b"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]
  end

  def shim_script(target)
    <<~EOS
      #!/usr/bin/env bash
      exec "#{prefix}/#{target}" "$@"
    EOS
  end

  def caveats; <<~EOS
    Please note the path to the Dart SDK:
      #{opt_libexec}
    EOS
  end

  test do
    (testpath/"sample.dart").write <<~EOS
      void main() {
        print(r"test message");
      }
    EOS

    assert_equal "test message\n", shell_output("#{bin}/dart sample.dart")
  end
end
