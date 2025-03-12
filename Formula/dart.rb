# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.8.0-166.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-166.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "5c265e7ae455ba3bc4546ad960d9a37b765938324ae773761b9c8a1268f831a3"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-166.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "4dd1fac2f8f5f2ef0bb95fee1ab1cce7a58a4cd6eae854fea422af7032461741"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-166.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "86dceb56be2a2b466a05e054a311c31d1bd6c773c2cdfed08a8ab4d2f6811525"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-166.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "b8d92385a083cdc6ce6e99f87c025172923ba77d341dc28daa7444fee7679079"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-166.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "7702afea7778bb1a4decf56617e5b99eac924fd7af5fb7d166c8c95ec3d2562a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-166.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "ab377adedd1760e7a6b9d4c51499ff5a11c28d6756629188a75889e0872d0e08"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "060886d2b8ae832f89ce7db971eeb6218a507e37071152487dd52eb256a449ae"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "106e63d9590090993a95ee51e68729de2d09ca2b7b7bd16c0b5fb57a60b3657c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "c216fdd70f656c50c78dc6a0ffae6e5ced7a9a7ccedea3e402fa6b5ebe24788c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "02d616ef67d8452008eb778fe13a6eb9ab03c805cfa9952a5b94a44b97a27a78"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "3452ccad61e057eb7fa17e85ed1aa035d44c36e33dac07655717798f47e64ca8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.7.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "7376e09dbb66aa8af25423a67c36f0ccb771ee280f12ed8157f1e26095abe67e"
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
