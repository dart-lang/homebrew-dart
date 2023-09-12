# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.2.0-143.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-143.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "f954156fbf61ce9d6002bb6ad3d49ef7d863572469300bd3c9706674ec05b1e2"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-143.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "fa25ac0df20b24251acff7c77b6bc316fa82e83b5d1ccac7274d12a8e62bf787"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-143.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "8fe75cc33abefa5eb9874a6a934fe9e7e080f513aaf727aff049e1549a8c064c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-143.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "3c9c433f09bb612a919767d99920c65db27daaf0f232161274962cd8d319046d"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-143.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "311e45240174a2a5132698671c29abafeb6239609091ffd6cb30e1e192c3de99"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-143.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "1d6c670092d993773443794e59cb00cf7d964873e0bfb396a5297ab0d81d5738"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c34e9b2c45375f86ea4fa948215079f3ba4394ce8904f4cf33664d82dd2cbbea"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "a0435e9084b714efb527a079c993cdcbea4aa3db81d6d16fe68235bf3e44f43d"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "1353d67c3c5bdf550f170ac5203b0722be91ff32fe756c36a21c0c6c208c25a5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "c189035346e7cc7fec5f321ca08d779546a6f1904be66ee4018effc649f22790"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0c5c4f2d25603bbbbc2e389c0460d84f145c44093f83b11606e9990cad7fc3bc"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.1.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "e279d5e475a257a84fa86718a559fd5760f80cfb92e3cf4f7143ed856bc3caa2"
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
