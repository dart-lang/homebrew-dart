class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "2.3.0"
  if Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.3.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "d94259c928d97b0b89fea3f6ab0f7d0f7e15d9761cc719db9c4c731181bd1d58"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.3.0/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "2b0a4365abda7bf1918d2faa18a326b567935c3357604120a9cc52f728aa6345"
  end

  devel do
    version "2.3.1-dev.0.0"
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.3.1-dev.0.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "72d75aafd260346c0a3defb24b0bbc6729310b66ed9572c169b647a04962e5fd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.3.1-dev.0.0/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "4c1fd89eea9b276322240e8819d37bbf60860b9a048ed71415e7c77cff330e8b"
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
