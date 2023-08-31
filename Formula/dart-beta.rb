# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.1.0"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-42.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "d08b8cbdf79de0cd7bf0e667de8d987ea1d5a88532109169c63d93d11e0d4c0c"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-42.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "cc5546a451e5a0cf7724393e580853faa26688718c975e1cd44338b4f67d79bf"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-42.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "bd0311f604def7e49215c6fbed823dc01284586f83963b6891cc6dee36da2488"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-42.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "311011021b55acb1bd8b2aafaf97eba58a9a20007d21f98fa3108d5dba003139"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-42.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "02de2c59d14fe4fcbcc6da756457be6966cd399bee507b2980d0e3c76fa4a2e3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-42.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "8bb319c661278852b371bd4438cc6e19860d0613bfe3d016006bd6ef6bf9e72f"
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
