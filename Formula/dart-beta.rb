# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.19.0-444.1.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "632fa2ebe00cba2045f907b7b4a092261e470c960c8b2a1fb8c6ad87a1034709"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "6fc4df0107e7721e440b66ad2cccd6c8be57e5cfa659299b2823d2b05ec7409d"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0cd028e661deded1b141348ebab1aa82814ee5a73ef226ff6c40ea225ff311a2"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "ee768c3e113d43a59b4a626e4b93a568e790a8a0e8dd98a5f9deae1808d88560"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "6c9384814d1d516eec616f40d22df161e219eb15d730105a28bf260f3274b4ed"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-444.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "b53f16f3200dd395701b7c9d0cb6aafe8e39c2950e03d5f5b1f230fab3986242"
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
