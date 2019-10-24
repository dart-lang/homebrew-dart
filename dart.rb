class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "2.5.2"
  if OS.mac?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.2/sdk/dartsdk-macos-x64-release.zip"
      sha256 "b433b05ce353d3683c53632fdafd053aaab6c49014c8702fa63936cdc43ea8d6"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.2/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "f5c3f7b001a734726140e8941f0768f3365193d27024a762b769d7c03304064f"
    end
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "afdda5e7b2a357fed2fec9511f12b4c4317d04b5a87e439a27d107104e98095e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "ec4291d0c57d36dcd9374428aac98a0fd7ee8f1ba30e1fe87d5e009d491a7b95"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c45465e25a299a9cb4c5c0c8dabd1c277eb25e6f409a28c0a286204474683075"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "16a2cce0bece594db4a9a89b7289b378763d708895bd63efbcd2dfce78487471"
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
