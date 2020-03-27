class DartBeta < Formula
  desc "The Dart Beta SDK"
  homepage "https://dart.dev"

  conflicts_with "dart", :because => "dart ships the same binaries"

  version "2.8.0-dev.18.0"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.18.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "10c63a444fe382061d9b74d9b609920a42b8c81bcd2c73917734e821faca0416"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.18.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "befe8984db19fa4ba41c1b4c4bab07c5a5103cc95836ac6df205c80def1e0964"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.18.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "aaac9e5d223deecaa7e831615fcefd61a8931c26e8abe8484c1f0e32fda261e5"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.18.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "dffa965f230209e9ebff1d99e8aed5c8067686cd588d12037a27e9335c94788e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.18.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "630a819d162b42cbf740fd7927a42a8325fb651d2ce8c5465252a3dd99f887e2"
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

  def caveats
    <<~EOS
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
