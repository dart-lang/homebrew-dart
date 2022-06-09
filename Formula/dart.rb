# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.18.0-170.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-170.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "1746da32fe49dc82c8087ee899a1b78b4f4ca46838c83b4b44ac888fda44b610"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-170.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "9b0ce7381c2cfb1524b429fbdd169603b8fda606d5656a11c9472fa3aff58577"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-170.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "b66ed8a2b5a8e3f5b612f424264c821ab577291fcbea16906bdf1800d2ab3036"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-170.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "72b037ac6b74be8d002b058275f95ac0141899ec7362509cce47eb6da61513c3"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-170.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "86d17a36df343b2e0fa76cd8a7186e0c939d8d36154f9724269e0c9266f8327e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-170.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "289024c19a7821200f7bbac606fa50eb71fe9af50cb50a0c22f293cfa0614d92"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "fbacb894e192f15c96ad908c4a02c5ba7d04fd63821a51c413c279710895a546"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "36392a0bd0da68518de3b41ee3ac5496c131d8ed9b42b2a16f5789cb17ebed58"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "68f9a09ac61aab1c135ad2e64a39bfac088900d439941dee275d8ea8c8541b95"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "04520ddfa39445a5888015223b7e4690c9210811e7aad2983c955eb5d2797192"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c993247b5adaab432fbb4d4b144d5a52c4c4011656312d2b008ef6ec51eaeadb"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "75d1f5969ae12298d27b00bbe5866cdfcad422102929b52dc035c264ecc979a9"
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
