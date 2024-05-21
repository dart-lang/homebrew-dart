# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.5.0-164.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-164.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "33596c458676c35ade44ca2e353b84748dcab015752209b522f6ef60663cb7a3"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-164.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "5b85b2f62c7e70b1f40cd241b5f251a85ec5f33772eb03be13e2c2f0f844ed5c"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-164.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "5f7e653396c50d33badb2d9ed278fd3cb6c38d561845a5d60e6ddf3caa6d95f4"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-164.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "8f16dc2c5c9148295e9b7d5b329078212f09e0fa914f25f395c4166c60336100"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-164.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "a20c2bf3fe579b5277696613d2ddf9a69c443f67112559fd506967c7be1eb153"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-164.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "16298e3fb263ab750642be43235775f3a8f11b71f76e7f2866446e9f0e1b2ce3"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "fc7c7c151c4bd2ec30d8d468d12c839c2be13c7569355ea60e0914dd1f7c2ff4"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "e7b6b78febbe2f6ed8795af03a90f19331ce97115107199119a113800d441c86"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "631acea14a87a3c5d34f4fbd67ec8670cfe1345cbaa8fb8a3c45095880858620"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "5fa0132def556dd45f163221dc0a5715f959ce6f1332a4d4a6301c0f849fe5e1"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "227562fab85cd9e7e842d282af376af0b4a717010b568016e0dd3b8524e7ac10"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "5553cfc3940dcece763683d71b23055bda2fcffa9fa1eaee721c1b5af2c73f61"
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
