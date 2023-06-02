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
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "3828de27699624d6d336a29c76ebb6d03a906fedda6f1ea69cd2357e39d1318a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "24e5b5613fe5da342ac942339d0ff9320a0e5630ca94552b5c4236a09735da11"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "c4a2c9fb66096680bc99f687343ba9c64cc4f8a9c583c50a71ab8a63339303fc"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "75d0a26962d449ed30e47bafdb2696804344528eed0c3ff9297651e510cd2118"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "d275012238a7ad416b819c74f303b152d676a82a97c3cffed01dda2915e38a0c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "e31ed76eedd4daf202c54d6472a4603cd60fe17d090b5e6782b18bb7b7cacee5"
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
