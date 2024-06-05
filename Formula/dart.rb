# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.5.0-202.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-202.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "c22778a8b59edfcf81f28898e2da22bc7b7d1386e856226faee407dec6dd26aa"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-202.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "7fde6f2ad519a2815e8093fc113b8ee5814c265fa2adb6a0a1df6ebe944fcea8"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-202.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "c01821687c7de65a474529d5b8e99e0f223016b111961bab408e1c16753f5588"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-202.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "1eaa8f713a5b0c4db529cd0b9bf29813a045d4b9be4669fdfc0696d9b193a5b8"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-202.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "6d1dc9ed0dd099fabac30142addabebf8ff3793fee08476b0e1cc90acb5c6c5e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-202.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "2e66bdfadef4e3d983f70cc058e9f613a3cf27acdf32ce05b881672b229721e8"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "d3c7df4f1405a2c8602d9eac780c9eda9f6539f40a60df435d0a040c886aa7fe"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "541c24aab14e7015aea91c1501bb59abf286b98d09133a1c7bb2092bdb923e4a"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "6366ae94486d27a0d450c0d9bb35b181978f700c7a547e98ab50dbc8fb6ecca3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "06b2b3c961c56a82c417534af61df32bd607494ee8643a5f35eff058fb4c8be9"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c155e6d2f09a3d0fe04de4600040798ee253662017e46bb451787c62f19bd576"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ffc16f542700371fa2ed1e2b18d72e804f67375f6f6dcf0c8dc0f014f16d70bc"
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
