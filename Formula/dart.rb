# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.8.0-21.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-21.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "7d904d1d5077c5be56472327feab2f5e60d75701a998367cd00e40eedfd6aec6"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-21.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "12b08325011d2bc0b89b6a1e705881f715e43a60a8f5071062af0d9dfb359158"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-21.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "0852323cdb125fe1bb7b17ca89e758bfa3f23f0ba6b8c5f97001f68f55538844"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-21.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "7e0aca82cc71862c055b6d7e9bd11effe186fdea6f8b8c3cdcda776c0de54261"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-21.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "5b56425b0c09c2b45a4dd627dd2fc09224528ecc263749ebf57b16639c263c9b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-21.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "fcfea41346d018be23fc969df71c3c3f50c1596839f9d677b7c44dcf20853600"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b797e4e9ab31192264a9ff8d148f3d58f05f0f8cdf82f04c59fd67832c55daff"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "8fd91cb89fe883c448a26e6e34d861d51d9451976c56db2287c5f2df80191ff4"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "fbed37419784149c93f3ae444b9a9d1b5d5b73a521cbce731899d601d9b435b4"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "23dbdbd8020aeba52c694eeaebe4c29bc2be5476056b5750bffbb2d231371584"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "9192cc5efe2af1ff91aae692950550ae4eb649656e5e003c76b4ed55c328154e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2792acd3abfba7f3d61fef7d0973bbd8069f5f0ebaa3a4bc47222cbf8d4811bf"
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
