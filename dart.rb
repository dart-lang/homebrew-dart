class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "2.5.1"
  if Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "eaa0418011d2a56b58c6b6c204966d01fd1ddc481a3879de63f7e9d56162ce0f"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.1/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "6e5c72eaedc1331cc231e61fa78630c1151bb10f6d2e2fb3046ca30729248541"
  end

  devel do
    version "2.6.0-dev.5.0"
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.5.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "baf6d4625cd79014d0656f10434825af3d845fb853593169a530d828dd4eb556"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.5.0/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "ce66429405253b1138e67a0c4e246a117222223e20ac8fbab6e46ab4584d6861"
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
