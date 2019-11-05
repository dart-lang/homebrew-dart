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
    version "2.6.0-dev.8.2"
    if OS.mac?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.8.2/sdk/dartsdk-macos-x64-release.zip"
        sha256 "0e58b44336e042aeb514fb3f599c2c80632ca5d12054ff002889cf346a90af20"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.8.2/sdk/dartsdk-macos-ia32-release.zip"
        sha256 "6d2557bea0d0f732edba9ac7feefaf0fd1d0a0889aca5f45b878e8ab9fbfc035"
      end
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.8.2/sdk/dartsdk-linux-x64-release.zip"
        sha256 "ac2ec0c43ae5cf7d58e4af30a7d408b7b940328cfed6d8d57e3e81f07470f8c3"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.8.2/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "bea60739d185890addef2272472e275f4221f4f4fa08c1e87977aa043791e80a"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.8.2/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "19411dce8df522a3299e5e32e24e3328838737c8b030c64cdceb98d0b75ad318"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.8.2/sdk/dartsdk-linux-arm-release.zip"
        sha256 "c7f7b83a671647e0f8a4b667daa8e98d297ae3fbca7802929bde03660a48e720"
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
