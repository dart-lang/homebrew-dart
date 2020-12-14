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
    version "2.12.0-133.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-133.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "0574868732c1020218f4c4c7c7305839416be8650f91dff4c534099638fd8811"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-133.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "66800ec6440cba06136753e1247a760d6da620afeda4b77365f50d5c074bd7d4"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-133.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "46b5f893638ecbb02065f077d2f1b88a39e9a7e653c66ed807d4676ad7eb08e9"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-133.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "4c3a91f3ade43f1660498f978008f639be9d8ebff76957cc8bf8be45e9f5ca65"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-133.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "1843096203111fa8f3fd18631825487eb5a25327464207469aa2ce825a07371e"
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
