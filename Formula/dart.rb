# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.2.0-202.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-202.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "a07edcf2bae9087ff31c7fd489fcaedd353318dac967e664ddae730d3334d0a1"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-202.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "ecb93866262c92b9df4fa5414c224cd4055730ef9c2943c61ca25466efaf3961"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-202.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "33adbd575bd4ec9ee682404d305002fd816ae909fe8c1007777f20c67712ec32"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-202.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "3a0dca684f42c3a0dfaa5fc05fc26f0f8a7cb80ae8441ed2613cc6293196541b"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-202.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "4cffcd38f32ddf1ca6ce2b361113cb85e7eb1300932f41031c7cb45206f5b045"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-202.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "a38e39af7d4491f62f8efaf9376ab62ba6b3608d8af28e86837ecfe36fb361a2"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "ddadd6bf48675440fa683afddc771f0917adba5e58adc5bd5261c1a2bcf47201"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "795ad45899ff4004403ed6aa998181f10936cbf6c8d7125e8d1dad6fb3d35659"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0150dff731ac017646941ebfa46ca2a7bbe5c634be0928262d524420341fc739"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "44e7253a10bcc34f898d2ea70cc83fef81a5d6489e8bf6f13b0655c0abde039c"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "2b2830001cd8732d356c4beee7be25c947e6cb6e8ca7b8ea748da47f6cc9d222"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "0edf3fe2f5b8d212468de67b08fd1f27e5a775ef10e4e8bbef811a083cf15650"
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
