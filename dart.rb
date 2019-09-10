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
    version "2.5.0-dev.2.1"
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.5.0-dev.2.1/sdk/dartsdk-macos-x64-release.zip"
      sha256 "bd14d68dee36eed07fcb8380d282c9a9baa7284630dd57d92135e7589a24d9ee"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.5.0-dev.2.1/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "089193bc42c68cd2a4ac231fe1487e1b1c277866d4984d89406a91f0de270321"
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
