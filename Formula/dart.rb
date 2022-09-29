# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-249.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-249.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "5cb626a2bf3999ea1088f0614af119b563cb88a807b8faef9633d6ecaa175e19"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-249.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "f263d252c826f2f7e31fe2f6185c87e2f9687f9548c264f3dccc6b0af3e0b595"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-249.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "3a81a6d643a5696c519806c48b7d8226a6258cfee1b0a0242a2c8581fcf69a60"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-249.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "37f7038c34363de19451ed6e0d667930d3be33044644db554464aa218c594ae9"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-249.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "36a8c8429de98eb40f54909f6de909a7abe88eef4566dc703f90131a5a84d834"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-249.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "779636e0e1c2882ca6759869cbf4d520fe1d47dd52fa5e8cb1de0d0ff77128c1"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c5c478d97f64b7bdfb5ac4e5c25724af177257691a17c9cfc1b59b069159e61a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "49fed61ac432440b2817666c8c09040cf586a66536d4ddd9e963dfbc30b29fe3"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0b7f988de7172ef4a626b2f08bd1fb4e00fd369d0002b456c7711d06b7d0a535"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "87bf5924eae72138708593e24636817f075d38885a6ec08a3de37397f4877e48"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "cf220ad62e7ff4fd82fac8f3740ae1170a553b83fe22dfbf5f9d25fa7f607a42"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f14ec4fcc222c88dfd5d1fec47ac527ee172e5b974974de9a7c5213922d05e70"
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
