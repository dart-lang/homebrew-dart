class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "2.5.0"
  if Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "e031c10a38a69a4a461ea954b851860ac27d1ca890df1e194777119707d7aa56"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.0/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "a595b26f43e35ba8cf405fca670ee96e9aafbf71cd772837cc14745198cf0c37"
  end

  devel do
    version "2.6.0-dev.2.0"
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.2.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "7148a51ecf84403480c689fa1f4d1376549531e4e28f827c2c815d0462e70749"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.2.0/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "1ab10fb7ff891d61b3a05008a879e5ab5d66de39779b858a2ac94655e986091b"
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
