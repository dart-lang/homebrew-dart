# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.18.0-181.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-181.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "4875e4c886b070adc43999ae42a36393f1eeb6e6e02488f2af31c97a4dffe387"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-181.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "52f523c9813aa8d85abb577123b42a58139da29b17777b26790f0fadc6523343"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-181.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "64962e4078f54e63e09607f135e9103dd712213ee7042919c48947130cd416ad"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-181.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "0f0282456408978446eb8519ce52f546e212ba213cf269522630a6beb7b4641b"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-181.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "5be0c00bbe4428fcc0724f0f926eaead0f9026f8f63df61b5b009153b5b116b3"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-181.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "d7e47e4a11f0cde5f4867dcd7cb15cf29fb31ee17f4c0bd2835c59610fd3433f"
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
