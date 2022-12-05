# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-444.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-444.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "b99fc8f10dd85dd59a39fab1acbbd899f3090e19fdea6a175f5126c5272b5b86"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-444.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "cf0f6d8e70e4f02feaa67d4064162e1ba6180e3afdf6a6efef7ee9aa0f93aa5d"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-444.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "d8a26139249f23d3d7d5d02114e8dabb1880d2a87557572bb6dab10e4a004de3"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-444.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "7e4914fe5016e84d88c3e3c1d1457e74c81e5a9d04e367674255506de60f1a5f"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-444.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "3664deb725beb26acb94d66e15de7e59ea4bc982a6f39a6a51f0e0fd25d6b661"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-444.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "de8a132f5fc7420df4476079941311e213d2cd0bc399533a2d1ab317478889d5"
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
