# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.6.0-334.5.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-334.5.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "cd750098e041a2da49e37efdbc2e633754547da587c073466330cae514d56c67"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-334.5.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "dd018d6afb37094bf1defeb2a6e864aea0bc5096be0c4a4131778345559faec4"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-334.5.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "223ff799cc05b63c1dbc7ca6ef1e58ae5d4d11fc1a2e142ce13ae55318fc6891"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-334.5.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "92281e1395098b08827e8e9993212e7cb784a03c049fe32b03a4ab1403e018b2"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-334.5.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "de02adf4740f4d4f97536a268511be5d750e592792747986c4dcdc4d15a5ff00"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.6.0-334.5.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "16b52f924dc57473013e14aa928b452a50a31ea38ea3f845b05cfbd36fea01ef"
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
