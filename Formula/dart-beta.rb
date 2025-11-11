# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.11.0-93.2.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-93.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f1439a207033c3358f06b156bb785559be2cd8e620f1f19e7e29b5c998b19258"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-93.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "b512282c31c319aa3d0d1e31be03522860b3dd753b622ff2077a00df3b7587c4"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-93.2.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "1874c0ced93244389bd4e91617856c5677839e02d8c3ab66e473bd9632fc235d"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-93.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "9273ebe3bda6e1ab009b0a4c446d2e33db5f30142939bf0534d89c6dee40285e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.11.0-93.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "729d2b5486db8606d973084e1036739396b4556834c03c75940e36ca6a7ce276"
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
