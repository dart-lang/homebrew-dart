# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.18.0-149.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-149.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "8dadfed6396aae5fafc3b917f2450e2971acb6041013fd6e9cca4a22f2bc0817"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-149.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "5bd9ba7ab780a9cab42166624c39bc32807eb043410f2588f33f225be049afd9"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-149.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "e6011fd465e20daf5ee8913dce1e6f019d2272523c556884f5b169e53fabc387"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-149.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "1d7db73146bfcd5a4ae34a8197bb54e68cf505395d175f40e9d2122796d54da4"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-149.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "5dadef203b4e71eabf7af32a9dd4250c8f6a3850c258a70767cd63c9dbb837ca"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-149.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "abaee9ab919785ebd904ce147af5eee779cdeb86da8ab10ae842d546a7c6b4b4"
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
