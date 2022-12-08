# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-0.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-0.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "0f645a75f4b86cddc613f2c74e4acd4fb4f11258273d2aed1b444063069cfbbb"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-0.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "b6c2d30624c94c169d9eecab7381d45d7f2980677c5e165621ab944d6f48a230"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-0.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "1d11accc2253df64b927c2b631b9921e253943d6b14e338afa3d7e8f84f98af4"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-0.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "f1172f7175e8a503b3fe52322415493da03d8d9bba1e77942825318dec68924c"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-0.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "8545067be105012f6d0dbb4426b7a28da6928f6f0e3d69e391cfd16dc4dfffbc"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-0.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "6a2181ca6cf43c9d0d543d3b31caabef26d2ff6d1bd6ff79fcae9239e57344f8"
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
