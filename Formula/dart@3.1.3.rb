# typed: false
# frozen_string_literal: true

class DartAT313 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
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
