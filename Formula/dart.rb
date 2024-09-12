# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.6.0-232.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-232.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "d40f2125ce7a3224cc6d9a0b07231ae162e0d2edbaf61894a677895be6fdc6ad"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-232.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "9671bf815adf8a21b9fa9e7b81906ae8274d0c345c96e606eb87190ea38c8350"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-232.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "9184387c38d835b75add87432147dec7babe32675b38b9c0a6dfeebb0edf9c1d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-232.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "18d7d5338fa627cdde653f746015234fe983a5593384b3fe29027ec52186d9a9"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-232.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "9fa0081cd512f95c2e48dc1c0388eac775b5f50e9aa40fe851deb9e36850e858"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-232.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "326924a40563c49b3d971b8248c9b4d50f3e0447255555963281a0b59918f816"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "65f00ed58e635574fe69708644c65f2a938034ffd424832cd0a73ec5d63c304c"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "5bbbfd94db56131a5ffbbe106f7d3b15c8bc3436fbf8aaaef32cf28131e1d20c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0b50f0523eb1cdaa3c18bcb88f78b4dddfad9e3abced0aef05b0fd765b980d98"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "c43199ade3bca564204f8df3cf63c5194b53003afc5f519660786ac17e932f5b"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0a382412154fc12ce6dd6d25903281e3c33922b0d3857bc541baea054f09a1f2"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "6be11d8bf7e9f4b9a04ba3169be9af7f407f73c0eee60c0081c5f3871762489c"
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
