class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "2.6.1"
  if OS.mac?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.6.1/sdk/dartsdk-macos-x64-release.zip"
      sha256 "3063a3151e91367fff95f63c781519a54674cc5e8b9bc847e2c6de96ed611a14"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.6.1/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "161122c60c89db5049a7617630d7a492cdb6bb2e73b23daf49a16bd9e2c0c52d"
    end
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.6.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "8cff83660635b982e1bcca700a30029dcab71bd8ce1c5eb0c8102ee6c51a587c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.6.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "3e6563cd028f83bdf8ec167cb499dee278abd81e16f1524b3c1b377c26d09283"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.6.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "4570933406a042fadfad1dc4b664cfcf5ab7c10ca83a0d0e9e7d5a7f362ac0b2"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.6.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "cf080fa8bdeae9b1f765ba3efab0940522506ec3077eb2751b4afd0a6448e407"
    end
  end

  devel do
    version "2.7.0-dev.1.0"
    if OS.mac?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.1.0/sdk/dartsdk-macos-x64-release.zip"
        sha256 "c732c1e8da484afdd382d9b28cc80d02e7ca833dcabfedbb0700a36a78bf2fb0"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.1.0/sdk/dartsdk-macos-ia32-release.zip"
        sha256 "cf43921428543227e73c833868634f706ec7462a73cc89abeff0f1519dc59cc2"
      end
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.1.0/sdk/dartsdk-linux-x64-release.zip"
        sha256 "6d58c88bfc4b55832ffd4b3bad03348d58482fb5573a260b6a94eef4e86e7873"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.1.0/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "cca90aee3f4f0dee9d0b4a85cc1f7684b728cfcd8e4aa56ae1b7877b48654db6"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.1.0/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "3aa5fec210059af937df394aced313d17d72d8aa696f951be11d0a1d438bc9ae"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.1.0/sdk/dartsdk-linux-arm-release.zip"
        sha256 "b9e392be99f2a4da36ea6e9f37358cad34e5e3a71e892889fa8779f72f9ab293"
      end
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
