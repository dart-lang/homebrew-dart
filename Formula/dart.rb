# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.1.0-155.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-155.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "5eb56f1ec7cb6b0e289cca26cca93f1522a9ad893151c1b0e1b450cab9f3f2ef"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-155.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "68f63ad0ec9a812c33186c154d20d7c9ad14e4b8b9cf66757102b42c6ab6d73b"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-155.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "913f1d69a0f3fb03d9b3509595ead08ada5d2399a5fc38cb4d62faaded57302f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-155.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "3e30ad90effb83bfb1bf93e00b60498379ca1ecc4ad12f75d573aff2d91812c8"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-155.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "99b75d5497646173fdcd5dc8b482c32c7c316afdda07c649ed46df3b1e1b5889"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-155.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "d7c20c4a9e6bbfc1f64d0d01bc8e15e755c087d9f6dc66d944909e4fbc064570"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
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
