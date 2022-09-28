# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-224.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-224.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "d3901c81881a362a9b45eb8d0b662c965df8980a03357b645058eebd487ab06a"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-224.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "15b16d63acc5d310f38e63057223bc208bb675825249ec7112421220172b1ef0"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-224.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "c618bb1aa57b7d68ac1efaeef48dd9be204155d44c97ac692e5eb2653ccc3f34"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-224.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "4a0381ca5a73e4808d28f3819e58653ed98c63926b77fa208115aea2e3e91961"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-224.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "4ec950d9fd12645df3d5f86fc620008b1dcc82c185509c06da9efefac48fd82b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-224.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "d58742fec5cc87c39369085caf7223e1f13f4e1c18840f754863a21d9358edce"
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
