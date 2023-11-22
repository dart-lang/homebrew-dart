# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.3.0-149.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-149.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "fec86f2d6ac2ef2ec0f0179031bf2a7ae0e60ef5b55a670e69e5023a114af062"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-149.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "6c43f9536df22adb9cbe5f0062c6bed93830bf0a502516f1484e96d47afc2dcf"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-149.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "2c251e482bce1010edfd93be819098ba0687397b0f2be323aaf5871bbdcb1710"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-149.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "dc6ec412c0e9a42bb0a1ef275371f685dd1928a4c4572aab7e6f3ef7c08e0f8a"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-149.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "bd7f8da2a0289ad31005376bf113ad1bc866d86738e61139eb4394e08c04d8e8"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-149.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "fca7de045cc9ca747de3caaf8777f14f41b3d62853968efc9532c37c18668fa2"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "58a63dfd2a15494b6f0f753ea92befbbb86fc793483d0793431f6e569a4981e9"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "6cedb6b3e743ca4c48cfecab48276f5a4e0ffc2a22da320b85faa8216f43f5bf"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "5fbdb0b5a2c2917b48f9cc433942580796630cfa807b25829015d52c60cbb13d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "683850230035a0ac3b1068e4e8f85263db1ac408dd0d504bf0d3ea2ded6b4256"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "3db9be1fc744cae98e45b67418e8cc16e845c0d37351665c6f21f992d9dbc6d8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "a9ab3f262cee396fbb0b2b20810a0ddc44b8e91e88191c87a3f50c2979db1f64"
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
