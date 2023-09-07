# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.2.0-134.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-134.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "d8d2f28fce60273d6a94f3cc20700f1226d33f2949e33015d28e6290c5752189"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-134.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "22fd9dc966e50b1928ff7437328e2a563517a31af6a902d3288f0661e611a6dd"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-134.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "f5f8c2ac64f6036cd803953343ccdb91b0a3d5d8781334245264defc507e3b19"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-134.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "855532c8779a638a7b21d51650f655c556b2d828d0b3988ed80121f7f4ad60fe"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-134.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "2cb230883ff63c32a71f4150db767101fdd5e1eae93160eef1386ba47a7c9705"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-134.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "78a6412b04fabb7d4bd4aeb499c5e2d59d69e9d90f5106e7807f41cd45f317aa"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c34e9b2c45375f86ea4fa948215079f3ba4394ce8904f4cf33664d82dd2cbbea"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "a0435e9084b714efb527a079c993cdcbea4aa3db81d6d16fe68235bf3e44f43d"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "1353d67c3c5bdf550f170ac5203b0722be91ff32fe756c36a21c0c6c208c25a5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "c189035346e7cc7fec5f321ca08d779546a6f1904be66ee4018effc649f22790"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0c5c4f2d25603bbbbc2e389c0460d84f145c44093f83b11606e9990cad7fc3bc"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "e279d5e475a257a84fa86718a559fd5760f80cfb92e3cf4f7143ed856bc3caa2"
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
