# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.18.0-209.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-209.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "aa3e07130f3f066a4f1ab052c0e7c8516db3fa42a1a7722e613e398cc967caac"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-209.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "097aeb59ed62bc5bd1a4cf65f0c0e4e8c0d3ebbd783cc2acafe54abf0b4bcf80"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-209.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "3c15f38a624123afebcb74d9ca604b4bb2a127a22e6f9317051a064056124be2"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-209.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "75f66c0b81bda3fa2edcf2d1f48477dbdaccb8eff94b5d77e1872d7f1624df6d"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-209.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "0ce72e97e2e935a2f319d6ebcf0353ac20f9f0d7b8080e5f413cdb9da7e98b59"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-209.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "44f0a3580208fd875160902d182314afadc8794a348f52cee036d7ac5ddf8ed2"
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
