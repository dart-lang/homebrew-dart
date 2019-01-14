class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "2.1.0"
  if Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.1.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "5576013b2d5e03f3d8cb85a6cd8820fec2c9a856c1510c0666ff2157065aa76a"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.1.0/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "946353103266e0b7b87f5e89065c0284b8ba01ab67d571ae2fbc568528773285"
  end

  devel do
    version "2.1.1-dev.1.0"
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.1.1-dev.1.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "1fd329771821d6f8982f47b61ccabc7177e9695a97a227ba14f3f4567c69d3e4"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.1.1-dev.1.0/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "5941aa238e88c8c36ed3d72cf189fb2d8f16eb02105979511d7bb75db081a69a"
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
