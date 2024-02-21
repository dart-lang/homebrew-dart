# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.4.0-154.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-154.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "cc1392b79b7fa5fe210b75669558970ac250ecf72fa20bb0128e6e14ee6aa7de"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-154.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "e4a4a224a1edf44e539ca83a81673e2118a61c02acde94111975aea47db16ceb"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-154.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "e7c8955e2a6f1f32923a5d277a5cac6961bc550ada54c9b6a577fa0f21a58cc8"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-154.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a19ea037cbcff0c9e2fa67028b2fe0bc5fc6b3b4ff80c9fcb9a5dc8b14df632d"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-154.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "b65102acdd27c6d8738dad89464f91b32d3094e9fd196119d5bd77b83c9a68fe"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-154.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "d9ce56d85fec87b80323b90bfda5bfc5e87bdf7115e02c82086d7e2d8f48b72d"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "304ecad745b2e558be5951e6dd54b42a8ab84a8f3b6c7667258404318edd9db3"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "b254b3f2987bdf7ea2b982855642cbea9b96e8973307cabf369ef312d0b38ab2"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3ebf6ba4065ec941bb3b2e82118ae06fce34125ce6f8289e633c4b67a56cbcad"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "423b1725de2c4ec779b16da7dca7f338c4c4557803a74ae70a8382551abe3e65"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "19684c1615b2070a6933972809ed61f3f236fc42829c77fa19737dd2e8b7b202"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "65e821835cf1eed37cbe53d7e18a9e81e3fcb13ceaabaf7a6fe09fff9dae3160"
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
