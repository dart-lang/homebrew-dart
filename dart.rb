class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "2.6.0"
  if OS.mac?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.6.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "115afc248b4689c0ce877db063c3b066c337a5eeccb1067102a31c3b661ab47e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.6.0/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "dd7e8250030c3a4a94a2d60b3975ab54967f742885311b860759d4da417a3c8e"
    end
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.6.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "6cb03180c6a344064daa2711a276a5b0d22d917f553ece9f349f3b2f39bbd96f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.6.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "bce2c96b467d46ebbfadd1d4c70e4f2fe6841668a6acb244a90262255c1759df"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.6.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "ff4defcf2dd092a7095d7ff72f6d68c7e6d9a31f8b99c9cfce30e7696c6d2699"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.6.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "08ae25b5daf34b9946c9693f9395fe39b64f1f1eb0d5dde66a0b95588003a27c"
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
