# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.19.0-146.2.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-146.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "26509e1785fbf36caa93080d630459fb6f20d41b791692777df37a70947f29f7"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-146.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "6073ef48904e9a7e903019b68899f57458ab451e7296df9f8b2dd924d7757ab7"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-146.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "f6188d09d91bf2759f5447246505d7096159c52eca6b59342752f2e015178298"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-146.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "49047cfeca522925deb72133a6a1e03fa8da2d6734484e46ce7c2054bac5e9b3"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-146.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "92955b5769f5aad5334a219e8daa6d323c8ae915bbd36435d835f23af0d9c8e0"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-146.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ddee1ac517edb839cd6d3a548409672cdcd616ab0897150811a1b842639ab772"
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
