class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.10.4"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "45c28ed3eb036edd1f5b0a7a073afddd1900f96abc3be085fe9335a424a228b4"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "789f56cb6da0cfb2b97d9ea0942bc3f26fc20fd86256b1101e0147aa9790585e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "280701c2a225ef08bc14f5a2e7e2c75350b1ae3d78f7fd27cbb2a0b66674d83b"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "13f085e477f93aa3884dbbcaaacb77c08d8ab6712b332a4f399b39f4c11be410"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "9f41091c8542fd50f0bd60fa9e5d4ceefe9c754a21684f802f89b54d2abeec83"
    end
  end

  head do
    version "2.12.0-237.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-237.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "431ccae157e6daaac3adcb843f44244b112bff6d32c5d53a276ce95d9a3da29c"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-237.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "5d7ade07decbedd0d32784255ea5c4c141a13b55ae3323e86837ba2c98a9b092"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-237.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "2c0a5d5d28dd43e640027daa6e0b4114a956de7faf7073a2c1c30046d142e1ce"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-237.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "9eb66d94805f5259e8905f5868f3be722e97424e74bd3a018e54e6db579917b3"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-237.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "b95a0220eb1c1e70a181ccbf8b47e510044b178ccb0c7d1101cc20bb39f60ab5"
      end
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
