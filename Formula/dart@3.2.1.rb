# typed: false
# frozen_string_literal: true

class DartAT3_2_1 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
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
