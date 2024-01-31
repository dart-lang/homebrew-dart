# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.1.0"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-279.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f5ddcb4f4b5e508884d68158c9a81bd3775381ee1358b8ee023ae741dcd9436d"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-279.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "bb284e7e5e6a0294afd6a01e6c169b3c5b92e661f861ac7a9ea908e6356f62b7"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-279.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3ee78f275fa8d76a59325eaaf6c2af3151fe7978063ec4a3d796f2696c99e458"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-279.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "7106d1e7b6d375836a6f019cbd49385e800e53497ad407a30b067aa519f07785"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-279.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "4f3dd4cf16e61f035cce76fc02baa0c28b83312a26e7620bf16748346af2194a"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-279.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "15012a59225525f37274550f05cf2d28f2c8ba8a7ff86df73f0f53b0d66b663c"
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
