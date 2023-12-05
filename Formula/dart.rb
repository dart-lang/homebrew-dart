# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.3.0-176.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-176.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "747586991134debb43aed89aa0c36f24c66bb25c0551f9b3e7146798e2607096"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-176.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "221a556ea31aa855338ddd0bca597fe66bbd0012c99b8320cc527e95dbc97728"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-176.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "5ec87f0bde23fe420bc88e47865604bdab40cee2bcf5c75ee167705d9f70e5d3"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-176.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "cf5c5104159dc366b169f903452e9cf0984bb47ee40ec6033668750624598038"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-176.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "98c3910ea7145ce52cfa68deace1db3cb4a45e6dac9cb466876a8f36e4e9734e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.3.0-176.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "da4a916df7a08d5965abd8a1e7cc3d92e5e04f9cac5793334492475fea0f728c"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "fde798ba6dd54f0b3ee8d75dd0428f1ecc2e9cadb17aca4c821a5981ab6a076e"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "5c757e6d38c018c018c150716fc27fe74743cd404366eed65bbd687671731390"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "2d83ce115bfb588b4ad7d64e31ff7b12578516fc021194104e23fc627f67b32b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "87bf0d8f5d3f935dd6cbc31fe64839422421eae28902cdcb3d79a7ba3e085a19"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c7703bca5bba8cb17c4469e75a8bf125f97ad62cc9e4b6e4f738cfa9f450eb24"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "c6118c7e0ac718c4e6a4d345ca44ed28343ec5473d9178ce0e31c5159a56d360"
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
