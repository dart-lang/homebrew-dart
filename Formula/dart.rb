# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.10.0-81.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-81.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "b10f420b56ac2247c4a2451eaf7eb41fdd90650df5e744ac6a216a738f1d4035"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-81.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "e55d472047aeddf564f340d2c0e2e2fc371e55c6ca6402c47b5d9c9f261906bb"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-81.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "1bcfbaf68b867605b9b053c47eed8c83b3db700dc5589658e93dcb2474a1b00a"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-81.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "eda713c70e24797366379a9f67d8e18dd0a63537143a4082709d75938a9c6a0b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-81.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "793fceb6520c598bfb85829de5c5671908d7c6802c57eb4d71bde90543a42783"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "4ac0ea9c9e68c1ecdd1a0df9202a48b5e0a76105e0e8551fdfc60daa4d4b0174"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "74bd98cd8c4aaa049bb616886a18237b66663e045c3934a01d7ca04816c0733b"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.3/sdk/dartsdk-linux-x64-release.zip"
    sha256 "008cefb88505760ae514062d576255305c2bcba40b0f9b7c70fd524d786d122d"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "2396d820adbd3bd15f334cdb1aefbbc32f473d1fdf06315af122dcd7c7269671"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "61ef78b034bc9b8f2b1a27166c30eccac2b1b5c7c491fdfaf50d9137d89328d7"
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
