# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.4.0-169.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-169.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "0dca0ed976e52e2181b80c6ce223e6df0eb31d693bd440148041aeccb5765085"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-169.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "0f35b38d7c3c7a9c59e2b5141d1e31e7fe96b44d6bca91c95efc8acf6e89ab03"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-169.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "74524860f6c4f9355031570930ab5444c7184b398b5e5161b6e1d850265b4c22"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-169.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "c972bbbe06efcf6e4dc32a4bd002b7ddaba58b1138b055426e3c5f434311cb19"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-169.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "52d2c994473ec389a43cba05fe5183e806699105ea84fc50b2fb271bf0c03e10"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-169.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "98e86606ca6075b1734a831756dce50f1bc694dc5983e6bf344cdc35feda1eca"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "304ecad745b2e558be5951e6dd54b42a8ab84a8f3b6c7667258404318edd9db3"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "b254b3f2987bdf7ea2b982855642cbea9b96e8973307cabf369ef312d0b38ab2"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3ebf6ba4065ec941bb3b2e82118ae06fce34125ce6f8289e633c4b67a56cbcad"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "423b1725de2c4ec779b16da7dca7f338c4c4557803a74ae70a8382551abe3e65"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "19684c1615b2070a6933972809ed61f3f236fc42829c77fa19737dd2e8b7b202"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "65e821835cf1eed37cbe53d7e18a9e81e3fcb13ceaabaf7a6fe09fff9dae3160"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]
  end

  def caveats
    <<~EOS
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
