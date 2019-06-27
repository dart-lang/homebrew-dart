class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "2.4.0"
  if Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.4.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "5af4c52660a082a791d7b808b738432d5b86bdbba9292bf9e1c11398d3804b0e"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.4.0/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "264ee414f4cf5c9935d4388717b23da3ad11a90b7519df364086415cc866b2ee"
  end

  devel do
    version "2.5.0-dev.0.0"
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.5.0-dev.0.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "734a001a6fad6f06fa9d1fd06b5a87a9a3b454f72f51acfd767df01095703f80"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.5.0-dev.0.0/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "731f2f96284cde22cf3c912d29c27e205133f6785b9fcca01a99d7bed00441a8"
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
