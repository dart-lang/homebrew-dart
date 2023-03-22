# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.0.0-290.3.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-290.3.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "6adcd14258e50d852b873ca8888e224d520af44d971ecbf44c6ccb1138a2efbc"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-290.3.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "d8ba093d655b3cedfa3398105b9ce820c8452c0086061c8fb3bbd7cfee8023dc"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-290.3.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "eaaeee6be87a140a08ae0b6cc76e23ff4e5cb0ef7bbfa8ffa08b90e26b826e6e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-290.3.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "2022489747d2ac1ab61a9b3e5982224238ac30d5f5bcbb0803252cfa3b9dd13f"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-290.3.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b8f3d1f6c65657296757455ac99fab5772dcdb333cc83d15d626717779f2224a"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-290.3.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "7636eb23c9053bceebf326ae46c8e7be57c5c3cbaedabe2a5a0d6c8717dcc5e9"
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
