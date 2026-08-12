# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.14.0-95.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-95.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "a2ff7a2307db5876a3a69e7d08abf27f752f688ef3396876fe150c3a9792a7c4"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-95.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "3a60520008c0b1526b27fc048c6503c4fc110c494975839f79ccc7a6669845ff"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-95.1.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "19ca9b7d5ac0276f94997c554b4602e38bb24ab0e2fc0163d04fe8e15d347f44"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-95.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "4cc6d71c1bada7718e67f4d47107cd2b44c7ed5ced997499bc0494344e15b926"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-95.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "5f1d8170894ef98fd1f7675531bda768ba4b5d4cc429ffefdd2bdee361cf90d7"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"].select { |f| File.executable?(f) }
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
