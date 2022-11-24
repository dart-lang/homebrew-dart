# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-421.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-421.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "bb0576c3eeeef2ecfe9b701ee4b3fc8f70434489697bd59fbb3a06c32db2470c"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-421.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "34181c204efb2bd27903e331dea249548ee7b864c2f936eba9245a79a37a265a"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-421.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "1b8c1d58e4b8773be325152b16cc86edaac8b2e885ca7d629486b5e3af97678a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-421.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "68aa2045c05485508503d64023e2ba49a031458150c784ebc99deffca5163ac6"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-421.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "7a31c77239860b22c42029f8090f4c7fd4b52924c67406c1bbc26637d477a4f6"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-421.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "1abc6fd208f2a68643d32733e96f2d3105892180e75fbb48754d3d611f1ed8c6"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "3993c549cd43ab486624e53287a5e1555f4c47eaabd53af30bcf4772ea48dadc"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.5/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c677da0c5b1842a5d77414de310acf961cf032c8870c564f2a8b7def4e4d227f"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.5/sdk/dartsdk-linux-x64-release.zip"
      sha256 "f64fbc5b90c6817d6f3a25cf9cec4277343cf265df233600838050639c593889"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.5/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "220aa95150a73931dc5606092291d49a291f30fda4abed121468f01ae54a7f10"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f8c6d7e1b0f090c536a64a6a130b065533efd83c290f4510f42325389a0c27a5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "505df0bfcdb1a22b6486718f6833514926f39f4b28f390b3b67ef8fc7b149255"
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
