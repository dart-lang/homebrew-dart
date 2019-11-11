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
    version "2.7.0-dev.0.0"
    if OS.mac?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.0.0/sdk/dartsdk-macos-x64-release.zip"
        sha256 "0224472901f8f77b255bf119c4d0f245ed446fb6d94b105de8f9d4e703a938a3"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.0.0/sdk/dartsdk-macos-ia32-release.zip"
        sha256 "7e49bcf40e486d9cad487dfdde9187a5ad1c7c3e4140df8b82e47e20abd15d09"
      end
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.0.0/sdk/dartsdk-linux-x64-release.zip"
        sha256 "e4a4327e6405734882ab100c8212219945857cb5b7b6ffd2ead7bf9ac4d0e582"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.0.0/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "47ed0fbd9f68efe75a009c40998ba8a31305f0a7f284c1608fc6e5753b21834c"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.0.0/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "d6102729d20289e896d887e70693a99cc4a904bb26b4e6773d1446cfc157ee58"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.7.0-dev.0.0/sdk/dartsdk-linux-arm-release.zip"
        sha256 "703c5dba6d46b97924421ca2942c81d0d20a3e7f4432c4d2355a6c3b18cacc34"
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
