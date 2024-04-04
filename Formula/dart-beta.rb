# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.4.0-282.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "454095e2a59451bfe6166356df2a4947ac70407452f13b87e4b7695195dfb9e7"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "0d304d5fa73ce22aae8361f3555038023ed0a035209aa5107d4b6e6e66d4b90f"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "9c0663d3de1ea0fd68ea2d1bbf2df06ce32e6b869c8a895881f9d431ab14ab18"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "5a476752a1675ef2dcb54545f90c4c124de395f9d9a654b2c99f834467a7f94c"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f63d89b998c8b34fcb27f3d522a229ab7c5b3233bc30bb6f4d98bc12dd921435"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.4.0-282.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "a74e19878ad8aef2945995150d7d78167a346d9f4d20df6a0b50dae9fb4ca942"
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
