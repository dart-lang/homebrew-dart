# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.1.0"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-174.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "e810296b8ed808ec523a105d01a7a9cffda1e60114304ed78fdebabad7993115"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-174.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "27bf4bb08a6874d3d0ae025d0954825e83ada78bae43034b50df5a28a23cb3cd"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-174.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3b58bb6ff1ba2580858e2e9ad0a1f358246ba545bdd092a475f62e6aa1396394"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-174.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "be5c43767daf7a3b144ebe64ce0b1c8cce965736a427e26fce33923e6e98630d"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-174.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "6eb38bec0f3167e7f892e2d074aa2b30bfb456b8f4b204acda453af4ca27dd1b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-174.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "c53268123dcaf9adfed22545999c626a7a2a33387406d514148847fa8191afb9"
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
