class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "2.4.1"
  if Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.4.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "62006127bd3acd1b7eb2e4fc7baed061eb19b80c4ba4af481db5244a081fff3e"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.4.1/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "3591578902f3b3ee155aa90bf893f3d0b50fd12567454a8f980440fa8dd1ff23"
  end

  devel do
    version "2.5.0-dev.2.0"
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.5.0-dev.2.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "df6e8039abeb427ed4aba31e905e28b3d8ab87f39cc03942c21a97db0a60eea5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.5.0-dev.2.0/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "89719e96dabae626372f81c3d65aa3e62f81b77b5f37caeb9331e50132d1a014"
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
