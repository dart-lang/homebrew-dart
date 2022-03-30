# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.17.0-182.2.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-182.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "8b4ee6baffcc3e4200bab08993074f82f6f44efd9ca15af1e49e275e7d191f28"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-182.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "d61a90e253b029435e19fa2db4b2b3d7b49cd8414e7c6dc40e3d6a498f41effc"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-182.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "c2754bfd46b080c58699ba704ae8212c04ea8e907bec1d9d83d8768adfa587bc"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-182.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "928480401d8f458b109adb984d596fcd549403664e924fc4ec4eecb338acf055"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-182.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "3834827f270d9c1fe285815339991ab7ee5862a6b3c647af933a8206a62a867f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-182.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "a0575c89e7ceaf1a196929da07951dbc8d5333b2dbde49d456769f55aaaa70ca"
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
