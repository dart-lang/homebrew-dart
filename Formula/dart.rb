# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-398.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-398.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "7127c993c933aad8f810ccbbd7f83b37ae009d5adf7243e686b35352eba8d25e"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-398.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "409c3f173d9b7ac40e52c2bf8da92a3a85078c76545cda4005ae3a6eac22653e"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-398.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "5f9338d0d6a774d310ff5900792b1ef047b8e2b6d50bc58b4d6ba62b7efaeb4c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-398.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "dee378764d801f145615f587a5e4e5dacc50566d057dbc890ac987c891b2fb16"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-398.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "cb6aaa1472520cb28e819e2a4d346c921f70a60821c717504c9e2940bab5e248"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-398.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "871d8407baefd72d1215511b578f5e8efb21fa7a60a00acde323b2a2d6aef0d7"
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
