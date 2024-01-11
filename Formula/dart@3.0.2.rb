# typed: false
# frozen_string_literal: true

class DartAT302 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "2acde2ba8619253140005b5753154c700bf2dcf71ef1a6a8d80f3ceb339d9bb3"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "2f74ffe39b80f0279dad79b51edc2136970b0b71ad3b01b9910aab7c8fe748b4"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0ed1bd52359b583336c2a3a85fb59661d557c2ec84c51360e23f9b98a61f50ff"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "2f62a112840dad61496ee24931e1872885690b89fda3f90d713cd9240afc787b"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "99ebbb0f2a2f6fe0d0c2df839ca750558949d7cc88ea3315c70ff95e11fa42a9"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "18ee02a7ff1117a82328410cc6f1af4e3525cddc4cf675858d499916fa3bf28e"
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
