# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-255.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-255.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "5185e43302ea6566c6a091875881766414b189be4484e2cfb7367f99cb362a03"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-255.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "38d213f40208473eb7c35c5b04d08b8e12fb7b25faa301ad57fdd7ec9bf9061e"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-255.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "a90213ad2f4df641388f966d03577db7f39a5f4f40e92ce58086de1dfe340d2e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-255.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "1f71aed7a4750e67fc4f0d12485e81913aa3f14cdbf7f326176e54d77d709e26"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-255.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "8c7520618ec0f7cd15fe3cbd28ec718cccb1c4246fab83d4ae93f8ebe7ca052d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-255.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "6b98bfadf50287133aefcef7cb23d9959090d048e1dcffa4409a2919c05ed5f1"
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
