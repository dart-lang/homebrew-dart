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
    version "2.7.0-dev.2.0"
    if OS.mac?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.2.0/sdk/dartsdk-macos-x64-release.zip"
        sha256 "7a9820a4712013f3a07930c81fc46218e8d3dd14dd3d80891844f3cc9b14c14f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.2.0/sdk/dartsdk-macos-ia32-release.zip"
        sha256 "25281fff1a16b50ab1a8b7bce5d6614d9025c1c9cafe070153a6c5efaa29143a"
      end
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.2.0/sdk/dartsdk-linux-x64-release.zip"
        sha256 "8184d40a50e2b4d024a1242e66f15ad0e284416c3f3889618c03cce2c87e3b2c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.2.0/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "f100dedc3594c2dfd983080bea193ffd33809e391007e11eb3b723f31670ce91"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.2.0/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "d50a8c857c54e01ccd32dd15280880389d312dd4115431e101947d8333440ba8"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.2.0/sdk/dartsdk-linux-arm-release.zip"
        sha256 "37f73171f814d46111c4447276f95c92523c3ce6ad8e60c9c62129729d899dbc"
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
