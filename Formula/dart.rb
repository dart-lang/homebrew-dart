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
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "3a17b8e5876ef4d2ef391b9c5ed041a3c3ef809fd83018d6881e19612bbee2f5"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c6d4437d2a166738eba640ecc7d436de67975dcc3a51d985dab8f109cdeb6bf9"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "43a60e3a15a52fd584b0eddd235f0afeffed50f6e15a56f4ad74d83ee8fb5943"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "6e5f39f9e7df0720a6146dfe4da6047180d278f706fb2afd840b51b887978d16"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "4e0ce122acc157d3177c0911c79ec25560d6465d8adc17a4de10d824aa14d0de"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "11a6e8ee6f0f449fb1f1657cb35acea3f75234de02c735fd06fc61ccb6dfd1eb"
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
