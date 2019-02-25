class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "2.1.1"
  if Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.1.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "2f80bbbc16b4cbd872f6e31912aa87a537412f3b417af99003521c8790542887"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.1.1/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "a19a73189f9dc2a3ff4557566c358b01774deab4811706e74e1bddeb43a76048"
  end

  devel do
    version "2.2.0-dev.2.1"
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.2.0-dev.2.1/sdk/dartsdk-macos-x64-release.zip"
      sha256 "7e1b3b94eb67dc2a40a7a45e28d1a2058cd219be5e62de700d82dc628af98eaf"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.2.0-dev.2.1/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "ae0456a0758a4ec7c340ce2f77d1e1bdc1bd6daec014946e40c0a53b819f44a8"
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
