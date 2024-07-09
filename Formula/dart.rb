# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.6.0-12.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-12.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "44c3bf7fd0c1687f11dfaf3f0be52363b3ab9411c4765e5c978e182804bcd0d0"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-12.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "fbfd2664ad355e0a3f1e314903aca6d3e7224910571962cce78f7b05d9aa699b"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-12.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "a88079cfda72fb57bd75fddc0462cf651b5c34e36e5797b9ec2e8d61285be092"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-12.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "176684691de45a5a1031ee3a445f75ca03bed3a7842197baaee5d5613d35ba4e"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-12.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "b41552f4836fe05018ad0b20dcf3534149f6244eca197c2c03d1181fed5d497c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-12.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "5f294e64e16a0fd231b78862cb329423dd09cf25d24681fe3cf0cf003e39fd1f"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "fda7beb096ef3a2311f4f11ab774146fc8352fc73f154132f7c76404a780f9c8"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "ca750214e3fe0f88c0fb07b22f523c53a307c184f2ed51c3d3dcd2cb9e7bc317"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "1968cc9ee12802317f9a2320165f6966cf949dc3574cac1cb91a1bc7f0de67db"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "a2ce567c7953c901af15e5ce89436d611f601bbc64f0f4a920700e9f1d61f902"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b4cee491863d2ca6c324fad2d8fe2dfa123f78164630d7ca5eee45b940f70346"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2ef98f20dd52440bc664d7f215ac888a40755878a0e96cd4356a8cbbf0c20b6e"
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
