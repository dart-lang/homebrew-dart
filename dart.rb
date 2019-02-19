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
    version "2.1.1-dev.3.2"
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.1.1-dev.3.2/sdk/dartsdk-macos-x64-release.zip"
      sha256 "1a25910a06fc175e7e844806ceaefbd2d65a226524b129e9afb0900537f5f948"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.1.1-dev.3.2/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "6ecd6135db5299874e6aca64452020bd8d2beca0dd36bff842a291a98544e9cf"
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
