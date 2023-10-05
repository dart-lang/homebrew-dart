# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.2.0-228.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-228.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "a86948b6cee23dbb018db755729fe4c9b3434e0758f101419a40e0122e5c7299"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-228.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "3cac931d5ce5088ba35920a1423ba08c7d1080bf05396f8d78211ab3e556d9aa"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-228.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "1c4d4e22b509f51ec0f5ac8ef59218c95fdaf233cc1041effe26ebfb89a0007f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-228.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "843ce17e3ecd35b4e2960b50b401bae4997905f3429391f270dabd7383128808"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-228.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "17e9284e02e3905ccb81f628cc6c819322d1c6f9267a9b51411bddab2c3b9417"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-228.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "0c547eb7d26651e4cdff546188ecda4f5d54ddb8122adc062c9568e728422940"
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
