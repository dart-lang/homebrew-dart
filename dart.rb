class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "2.3.1"
  if Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.3.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "be85c03bc5bb386d93a4d9fbf3a687df5d86a9e675b34f5a42002943153ce061"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.3.1/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "f4c306049cc8359d105882cc8222e9bdb64fc24f53d2375838943543bd6062b8"
  end

  devel do
    version "2.3.2-dev.0.1"
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.3.2-dev.0.1/sdk/dartsdk-macos-x64-release.zip"
      sha256 "968cc3c98a39889bc33a6988f61dece6ba5f704250427ba4dc7a4cedf1faaba4"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.3.2-dev.0.1/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "7d5d71ffe419bb0d36dfeb8bdb09536e8dba1e0aa06f3ba134f7ea2320d6c546"
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
