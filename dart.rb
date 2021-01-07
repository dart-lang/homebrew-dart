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
    version "2.12.0-198.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-198.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "79f68a952f9d5caa2faecf543c23cd9b495307696451893cdda7d29caaf2d600"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-198.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "6a2f9a81673b0b606fb6d865da37e271ef98ea636944d6e2acd7298b33c08222"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-198.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "def9828476efddde0c23d8954091e7f532704ce07ac56ba7a9c387af3483fb6a"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-198.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "b12e0bd51bd19a2dadf86286a544308110a76527c9a2b2a8c5683f44568b9b65"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-198.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "4095c31224cb0c8b9e9a9e9aeb7f5750f03934125ad23c2b84abec6869f45958"
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
