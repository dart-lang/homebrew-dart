# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.2.0-36.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-36.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "d1e1a490d755bdc9f0ac7f26e83b68dae9b6ad30b8957e4137b2c395c9dde7fc"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-36.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "ed1e1af8cac6b2acdc20f2492e219d558c77a112c9b73e2e0384be67f6ce7f36"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-36.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "2568e0a96c972ddb4a71b4200d12eab0e765d118210b72d96e1f71f4a5385f67"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-36.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "0adde9b4704f4fb2d8013b43255845138879448bf658f76418749f5938fd496d"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-36.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "fd5c88fff16c328c7bb8f3ff8fa00578657b70ce52b0843f86cd2a58ec87fd90"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-36.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "4526f46c71bc0c5d12613bbf8c8abb70096b8523ea2338820fe0d8679c5bf8f0"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.7/sdk/dartsdk-macos-x64-release.zip"
    sha256 "cb8e8bd8dedef5308795cc3d4917a00dfbcc73742aafb0d95bbee909a3ef398e"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.7/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "bbb6625d89fbb910543f185cffed88aae1bdb8ab1e487496f3a5c3d18159f979"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.7/sdk/dartsdk-linux-x64-release.zip"
      sha256 "cccd5300faa5a9abce12a5f77586e26350028cea82bb4ff8eeb55641b58a2e1d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.7/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "e2e94c38f93a1e8eff4fb27ffc5c13368142499b0e8283991839c4d63efb0658"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.7/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "2c8eeaf0d3da60c4e14beec45ce3b39aca754f71b9fa3fb0c635ee28d6f44708"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.7/sdk/dartsdk-linux-arm-release.zip"
      sha256 "3a15d42cb1677ac5e50a23045cafe3bf5db2855a5287a3e9019b849fe8477897"
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
