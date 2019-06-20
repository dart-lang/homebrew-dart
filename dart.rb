class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "2.3.2"
  if Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.3.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "2643c435c4c8fe1b39c9d73cb63ba8a170ac42609b6e91e08416911bc0418031"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.3.2/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "d92aa28a3c1742130f92e70c0bf767f7c3f6456392d7bc93fdefbfcfbb5a0e99"
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
