# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.5.0-180.2.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-180.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "caf3eca821a1848c3ea2fb5c6f66f52db4e88099b5d6cc49349ac6407b45bb9d"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-180.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "bb47603a2caa121027f98a1771391f013f1b0ac03b9d8f19cca4301a8428266b"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-180.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "1b1b4540109e4532c28a176fb5bc67e780fe723a0d9369ec563f032565c58b32"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-180.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "9d4db900c912dea24ed6e0130b23ae97f8bee21358fd0fdc928d436f514594f5"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-180.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b4044b1069a483abc7edd11412554d59166c01f9f15d3bcd7ea1f799b45af215"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-180.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "a28593382ef316fd6b720c4962fc9188167ca404ed2cb0980e61cad24b0b8344"
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
