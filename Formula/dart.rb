# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.10.0-75.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-75.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "1f61cbde8a6d3b28590346f2007aa148d4e45cba2847cf6ec94699fb1ad641d1"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-75.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "fa7afbfec09deafbef55de9f8723518f25d848b3be3e0a6d8de1489f7c6ccc58"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-75.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "71563f47e126cdbc6e7277d59a5c7147eeefaf2b61040c578142b6165989b19e"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-75.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "87cdaaf4ba36834a91d41e200fc000aa59cf3eeecba9f38a5f38217b5d929882"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-75.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "2af23b1c6ced8e6d4e3bd3666bc5af805f8221e3671982557b8820509c1759dd"
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
