# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.7.0-164.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-164.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "c65f4994d7ceecd44c1819eed82786826ba6a6df1ada81fde6d68775cab405a5"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-164.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "033853bc54dc5ac980a5e41635c078e9acd21e64a62572a0dc83c6101e3109cb"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-164.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "956ff6647742033de387e9b194e871f7daa649cb377b457bbe07d6664ae3abb0"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-164.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "b00839352103ac52b58e3d27b8f1c7af4dd47c7a51806b622e10c3bdce20d20c"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-164.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "7e83acf7ccac8cda8369e1258e9b59d1253a65d33caa9a2e0b585a7b0409f2ba"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-164.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "287f34943dd994fc2add979ef17522cfb8ce7cd1a1b670afed25750507246568"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b06db3f3d0e92af0939ca467e87ecababa96da4f9fe5031a788304b5df949374"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c045940e0f5d4caca74e6ebed5a3bf9953383e831bac138e568a60d8b5053c02"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "8d0c5e34f2a9d6b9f5ebf05252ae1703893f6087d547c631b390aef2d0cd6967"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "2f90a98cfd45427555b06aac813f70573ed5882a512c3f2cf1e732ae53087b0a"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "a91d64dd3173349cee58c82f5ebf18bb9670f65eecc26d5684124c3def3f83ec"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f56d635ae4119f78ed887eaf8fb5e7821405fc10816d8ef42d3a9105c7ffb1f4"
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
