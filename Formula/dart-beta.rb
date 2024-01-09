# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.1.0"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-279.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "d24d69d89eb290f821a8b8949d7a0dbf371eb904af64fd2db14484dfe6b2e233"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-279.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "3bf607bfbf06880702887eb9858cef5c4e12fc09c9f4c09442f5079502e5cb67"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-279.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "a7ed5168acabce7cfb292de210d5fedb33a481548470a6e8142b20946ca81cfb"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-279.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "7b6b2a5078f9c3e03afa11aaae9c039f9d1364513155dee65c4f101ec590c65c"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-279.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e9516c29f1261dd985685a0d1e68ec85c531795e6aed6d7da72604a9a978e9b9"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.3.0-279.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "de28b2ab3d772026ee92d2911c0c476c147341d67a0d1f33a82ba9ba858a960e"
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
