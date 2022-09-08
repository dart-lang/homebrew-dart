# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-173.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-173.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "b97c538f76821217dcf3f8ad25875883e3d6a230e321e748597b07ad36ad3aba"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-173.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "899c034121230cde2a90d2b3cb9b4cf4ded4235814b9ac2b447f227b23c62cc1"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-173.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "bb9bed8d193c5557f617eb4b89d4aee5894a806d5560157fbe6f5142ac1fadd0"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-173.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "0e7910eb0ae38be6ecb14d2b259608c2c2f87ef7b91a017f6e1299c7536ff46e"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-173.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "08379b473b7b9fd60ebafee20e4646053b0395e3d2eed49b243b93802a1ec201"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-173.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "ca5fc188813cda3de24a0fcca1882440a1a4f8e703e135eaeab426a845a05357"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "cf2bbaafc6a421dfc01e904a1fde702575eed4b0fd08a4a159829fa699d2471e"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c1f521eab5f2f23002d135502735e1e12ad5d8342cf52bd8f0f1ad360671f9c0"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "e391c4ed8f623b9748f897cb585d629057c1141f9eaf8e9b2be118932ba11632"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "22448959f028713d65f05da2800911f98e4f3580f93d9d23db50fc68993d2426"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "06dd7c6eb6c903f5df8b23f9a35f7b1c35ccb869be6b5019c7dd93868ae2bfbf"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2e83b4a03a9210713a2c65d2c50bd680984c414c3c89d78baba5a20f378fac7d"
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
