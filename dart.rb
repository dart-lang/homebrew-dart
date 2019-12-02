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
    version "2.7.0-dev.2.1"
    if OS.mac?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.2.1/sdk/dartsdk-macos-x64-release.zip"
        sha256 "7c9f2fed89f9670a72d3c4bd60c673ed2ab176d9f65044b08b8d727e70f90c1d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.2.1/sdk/dartsdk-macos-ia32-release.zip"
        sha256 "d7156c4d70a153ee133973d61442a72f5a0483af4ffa418df6a60693c192f4f7"
      end
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.2.1/sdk/dartsdk-linux-x64-release.zip"
        sha256 "071cb515520e057ccc05f4a17f876c7bdc4d61da095dab1f9cbaa9ea4abc542a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.2.1/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "93ae20a07faac62490410c730be473618843774eef6f14087f895d47ab61c5f1"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.2.1/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "ed9cd4fda7e0faea293981ade14f8dbbd6bdc3fc2a87e86fd20e3ec28c0aa741"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.2.1/sdk/dartsdk-linux-arm-release.zip"
        sha256 "dd58defe1b1d279a7f546e60d040ccb434dcc5bd8cd8c13c7d924df0ea851f9d"
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
