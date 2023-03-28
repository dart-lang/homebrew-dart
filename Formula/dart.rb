# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-369.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-369.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "3a5266bcfd6bc15c53cb7e9dd02830b9fc3c8bf370008690d131bc7212adff35"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-369.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "269cd67bb28e2cc552966c681a8b0a81ea0f14dbdf05e1bea2bf0a5dc9fa2edb"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-369.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "ca5318cfea322d5122cf4e6fa90c2165bac8523bd84e5c529dffa8ebc147ccc6"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-369.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a0d796caa48d5837ad57f0355a42a3bc9b881b64849189ce0042c8f803636df0"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-369.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "3ccc4dea7af77f5e3510910365a6234f9fae15cbcd3731ef695b00cda4c5c36d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-369.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "a99190c363874671327b152f89dc469271d02094f0da3d496fb17607d8f9b824"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "d5186e8d9a31260b3528b1e595be1744e76035bc136733860064c2483e0d3bd6"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.5/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "af19ba3c7ca6fb31a7334d960d4a002672dbf26b6377254aa28ffd67dfe4ea3b"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.5/sdk/dartsdk-linux-x64-release.zip"
      sha256 "1c56de9877367f2ba9bd78f1916c8991a464301814e052e413186ea3f5edcaa5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.5/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "187e3785e721cd38939600fa94a7fcd507b144ff59f6d11b80f85d159f47abe8"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e885c4a96fc578d3dd5db7bcb7d5d4f86a2cc3eebeacd12153787982e0f0ce10"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "5f6773acaa41fda33cb266b0ad1968bc6d6fd2f876b43cab62692ac5273b0861"
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
