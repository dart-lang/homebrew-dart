# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.8.0-197.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-197.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "78ca3af323258cb1c1476b1fc7c7197969abd5b3c001c7a0e337357052210b3f"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-197.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "cf837d006d86900dba9ce3dc2293ceded90f2b890e62acd93d0bca14c0cd3023"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-197.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "2bd57ba0c16fc9354ca04237417051b82ec8f7e59f318f384d54217bf04efbce"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-197.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "eecb15f537dfb5a49aefec8cbc6ac9eb9a56219bf773527332d1e75d483e1d40"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-197.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "0a4fa277bcf01608e122ff5b275bf01dca0c89414d77b2aeca6a044a47d32ac9"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-197.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "355dbd869382607ab4575d27b2a127442354c0286e1a94b68413b2c06c1d27ec"
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
