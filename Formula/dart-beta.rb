# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.4.0-282.3.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.3.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "7e82b6743b060e5adb55afe6386bf3a9bcfa25d99a320cd9342254df055ab1fd"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.3.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "ac8d22a32067b72916b77dc7dac9187f43c3f2b9b60ed164923081ebe90e2d18"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.3.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "2625bfcbed9a8aedf340a651e61c9aebf5803057bc871ed55d981dca52437c51"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.3.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "93b9445b3ba5e3d8c2f41e86d39414b164b428be82b920b76db6cadae71e31d4"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.3.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "09a381280cb2987a6c3059d62c4ef0d3dca3b02990f40fe276f0c669622676c6"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.3.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "89d420f4f8b5b30c07e494f88c8c2579e54f29b7d15b3d18506c25c520c30dd0"
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
