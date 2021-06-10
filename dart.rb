# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "Dart SDK"
  homepage "https://dart.dev"

  version "2.13.3"
  head do
    version "2.14.0-188.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-188.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "7d69003008d162c9f0c9bbb4f2c242c631004a4380b93559db67c37916f466c0"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-188.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "d41a6d499dfe795c8dcea74d4c277c5a6a1d573d62de2dc2a22339ac0ebf1914"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-188.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "c65c4cceaf28fff7f754bfc428b5b9211714feb8daf044d66a562df31d682d5f"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-188.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "283c2ff7f9b0f7c1e674ba6531159f276af89e57c2858686a3bb8c07a2571994"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-188.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "bfde473f701270df49617ae18d27ef8ad9860eb0f4c95cd3dcd133e54f697487"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f5ebc9da1554b2901ae8fe46f83db3215acd4579f396d521f506740bde7eb73c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "b33ef6cc021e88345acd06333ddbbb5771130f4d23fdb6eb79dce7c31b78071c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "5b7f86633c9dc43893a179f8f6c42a74148d348269b0b3e0b40bde05fbd41be3"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f48adedbf471981b140d37126be0e54af4a167baebdc9e5241656582a930a4d5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f5a7dd1598eebd5f0fd20704adf6acc3cd23de1f2b93b6b59a657dd524e14b17"
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
