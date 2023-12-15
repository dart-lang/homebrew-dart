# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.3.0-223.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-223.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "ccc7034163e4e5c2bb46b640a77fdfc66ddae278f1133d1c8fe42f713564eb6c"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-223.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "8d2aa272e3bf5f7755f9989dc4a14bcb9bc4ccbf113f00e49184aea41603a37f"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-223.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "a88249a116bf67eac1c1f622f1f511b4c569f81e5951e26fd3bfcc3f8137489b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-223.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a495db3cad8e2eb759b9e0f2e740fcbc2c166004ab086ddc8834eb015da68752"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-223.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "0cede6590e9e9eab121a92d33e3bd467edce93d51566668f9ca306014e38cd8b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-223.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "971bdab374190aa6a7b1c6d5b23aea4d3b60d2cfd3ad7aeb0db2957ea4b8d8a9"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "716239fe2fc0237e5a31446ab5e3c95a8550a6bd7d5c5ad404c2dacd3aa4953f"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "a35017cf51e1e2b86801fd9e0937d7690559f096631b57134527f51f2d6708ea"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3a1903a8743422e13e93fb3f497c179fab5658ae32b9151a7baee3158461e0a5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "a6c19ad36fe3a58934130bca0e0801c9addc692aa2815b4bd9dda556c38859a1"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "dcf3c8116070c77f2376cbbd5229712a4e6874ef66438c0611e2ef23f69b2862"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2bb8a9faf7de11294c6c0f327cb7c328357f8872a5112e7d3abe6d35bc5d8199"
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
