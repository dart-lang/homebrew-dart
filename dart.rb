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
    version "2.6.0-dev.6.0"
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.6.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "6433018801d11b0dfeea07db1bada9e8a6975141987f929411a22df060fe9e67"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.6.0/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "cb0d6c15637ed7bc39d8a0f5f1d2143e7d9170faeb9ab26b402c5269c491054f"
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
