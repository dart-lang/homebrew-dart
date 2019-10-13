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
  elsif OS.linux?
    if Hardware::CPU.is_32_bit? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "ec4291d0c57d36dcd9374428aac98a0fd7ee8f1ba30e1fe87d5e009d491a7b95"
    elsif Hardware::CPU.is_64_bit? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "afdda5e7b2a357fed2fec9511f12b4c4317d04b5a87e439a27d107104e98095e"
    elsif Hardware::CPU.is_32_bit? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "16a2cce0bece594db4a9a89b7289b378763d708895bd63efbcd2dfce78487471"
    elsif Hardware::CPU.is_64_bit? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.5.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c45465e25a299a9cb4c5c0c8dabd1c277eb25e6f409a28c0a286204474683075"
    else
      odie "Unsupported CPU architecture"
    end
  else
    odie "Unsupported OS"
  end

  devel do
    version "2.6.0-dev.7.0"
    if OS.mac?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.7.0/sdk/dartsdk-macos-x64-release.zip"
        sha256 "558b208d11d68ed0e4eef3c0e5f6f649ca32bb680640774ce4ebdadf20340382"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.7.0/sdk/dartsdk-macos-ia32-release.zip"
        sha256 "61c0be9e9bea8e12329bc0781e2c781e5f02de77eaaddf4291139b69004d8d4e"
      end
    elsif OS.linux?
      if Hardware::CPU.is_32_bit? && Hardware::CPU.intel?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.7.0/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "3fa0f0faf4219a6c9ce64c18e8017656cf8d4ff045d21356fc82a95652f76363"
      elsif Hardware::CPU.is_64_bit? && Hardware::CPU.intel?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.7.0/sdk/dartsdk-linux-x64-release.zip"
        sha256 "fe80e20db2efce6c3a46108bf44e61a8fdd7f54e821325e76542cb37fb5e029a"
      elsif Hardware::CPU.is_32_bit? && Hardware::CPU.arm?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.7.0/sdk/dartsdk-linux-arm-release.zip"
        sha256 "8c5919ac2b21595f9609cbdf6e74c7ca5382236b781d9459fa65bd7499afaf04"
      elsif Hardware::CPU.is_64_bit? && Hardware::CPU.arm?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.7.0/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "9a7738c0eaf3dafa56a6164eee3ee3d568e346bd5be4a0346d625be2f0d66073"
      else
        odie "Unsupported CPU architecture"
      end
    else
      odie "Unsupported OS"
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
