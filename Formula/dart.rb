# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.3.0-197.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-197.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "0c6f70320e94705bf4ac50604e21df211b637bdc9f08be32731450b11ab6d718"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-197.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "2d3ebe4927cb90e679df86a77b0b509e0fdd61545ba80dac0e796771793ddeea"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-197.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "4c3bcdfbe4f812990355b831947e028a249dc229b8771720e5d61dd2f4cae657"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-197.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "d1e39f4e4274c1cd5b27c966fb818619e9cf36b63851f432f274aed569383b96"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-197.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "44d5d796b673b31a62d650d58bf78e456983e3dffe7b18d2c05a729a0eb68301"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-197.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "f45598a762eae220d383740da70b11886aa245dad51e5291f7dac0a324b1af3f"
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
