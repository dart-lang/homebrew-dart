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
    version "2.6.0-dev.8.1"
    if OS.mac?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.8.1/sdk/dartsdk-macos-x64-release.zip"
        sha256 "c5ce77d8d0f0dbdc37f240f3202998757ed7b21b5f5d0966acc8a1f6b9f60329"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.8.1/sdk/dartsdk-macos-ia32-release.zip"
        sha256 "93811f8b09a3d4489f3ff285fc1d003fcb8f485cfd8f298ee746f0ce65a256c9"
      end
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.8.1/sdk/dartsdk-linux-x64-release.zip"
        sha256 "26973b3bc6bc8d0ee3dfff7e321413a937320195ebed6aad3fc44fd7519ab457"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.8.1/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "edff5172c3d75fea75549561674fac8497a63329ba02ea97a8acd41bccd830df"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.8.1/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e89bdc7a7cc5db1dbe4acf2fcd66c432e9e2bbb1f1d4c3f7e42b9ef58b1e8821"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.8.1/sdk/dartsdk-linux-arm-release.zip"
        sha256 "47330071c241f130135054e253b22fd6bbb6acf5025375a8e65235bef4238171"
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
