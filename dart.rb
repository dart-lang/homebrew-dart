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
    version "2.6.0-dev.8.0"
    if OS.mac?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.8.0/sdk/dartsdk-macos-x64-release.zip"
        sha256 "aeaa72c99a65822d86e832f62123d55286cd1fa6973d8bb97493f84cf3ee02fd"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.8.0/sdk/dartsdk-macos-ia32-release.zip"
        sha256 "be6f392510c60892cff261dd66641d9ae53e44290857402ae30fa0f556ea2c02"
      end
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.8.0/sdk/dartsdk-linux-x64-release.zip"
        sha256 "5172ac2aeae298123fdcba73c0a7c1aa41f6a6f8796b627bb56b8850149cfcc2"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.8.0/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "9414cc68ba71fc6bc91d74ac5020ff41417f3db64d6850e4878786ac3c9306a1"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.8.0/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "8a101b1dbe4e1496789aa06cf743cb5298c7850a83dd1528b9e347a897ef23da"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.6.0-dev.8.0/sdk/dartsdk-linux-arm-release.zip"
        sha256 "dcfbd6a79a68327463692f63cc4ac0991fcaebfd3b75a831ae5c6d2b8b5fa921"
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
