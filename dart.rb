class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "2.5.2"
  if Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b433b05ce353d3683c53632fdafd053aaab6c49014c8702fa63936cdc43ea8d6"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.2/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "f5c3f7b001a734726140e8941f0768f3365193d27024a762b769d7c03304064f"
  end

  devel do
    version "2.6.0-dev.7.0"
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.7.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "558b208d11d68ed0e4eef3c0e5f6f649ca32bb680640774ce4ebdadf20340382"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.7.0/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "61c0be9e9bea8e12329bc0781e2c781e5f02de77eaaddf4291139b69004d8d4e"
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
