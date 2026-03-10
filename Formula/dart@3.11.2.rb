# typed: false
# frozen_string_literal: true

class DartAT3112 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "dfe0ac83b0cce53d9b409298151afe97f1c4574e53e4b16e04ad3b68d24fa96f"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "f0f8eefc5489c1952b952d3f70baa52ae05412c448ec1f8d9d0582dc733b8645"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.2/sdk/dartsdk-linux-x64-release.zip"
    sha256 "e646de59cf9bfdba8ecdca7b27a7d6bda3bd14b4a2256728b58172fb44bbd672"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c594d646319a755d332e8d438e1a0693214e73b2fbb798d0a72d909373ba6646"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "1a92197956e98fb98f2a10a841337ca3e21ab072401fadbe513a4009c0c81d7f"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"].select { |f| File.executable?(f) }
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
