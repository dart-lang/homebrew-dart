# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.8.0-73.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-73.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "5c399dabc25d60fdb37e50b6ebbc458b85e85523526af1f332acfaa547ddcf84"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-73.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "e1921e518d5dedc168ae7144d53a23eb621c3adc6d86efac5595e705d5c4bc66"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-73.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "34834f17ac0118c2443bf24e993c286d1753d3c45fbd0f73e786b9ef4aa18045"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-73.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "870077508e1f875331bdd3885c7df0010063cf9e4865291d3576065256dbe9f7"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-73.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "777d7675c944be51279e814194a37e66762047797c54f47ad23b0e2d52dd6729"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-73.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "0e45a57ac8e5a47898fd4bf4d3494e08427ef16d8de1722afe9615ef2adb78d6"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "8ac74b6f5e0524d767decbb7a04e93482be4a09d012cd577f29113893c19bed8"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "453bbfa3d73f28e090b644268e2c809b899d11a3a6507874715e1a4042166295"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "5a2953ec76c8139cd73d0c0b482de26d0b86a5a7e37579167bbd33493063408d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "eeb3cd33ba4d8be2cb5e43c3283a5034f009103cd641eef6f0e3cad701477c43"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f475db0944922d9925b4a4266c31f8fafd39b01a3cc130422e785c8276eb13e5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "fb06585de5d9b2aacbf8970be69c91292b29b4dab315b84789f0fe528675ae16"
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
