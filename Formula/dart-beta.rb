# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.14.0-315.3.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-315.3.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "8cca43cda5493a2373fecdf8bd8510dfc3ac69819c5570e58976ddf33c1c068f"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-315.3.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "0b6a681585f0ddac7d7f0c847d91deb4f40ef95221b033141f04b804a09587d6"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-315.3.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "4e54a80eeaf04055501ac91708de4a915d61c5c0e1a4e06da4da1d1f511f38ed"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-315.3.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f9b6819da79893a371b0580395f462a7c4d76e20cb3476eb7f78da4663064414"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-315.3.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "6eb269a079eccd8cafc72e25b183d1037437f597fd8119ec06558ac3b6179cd2"
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
