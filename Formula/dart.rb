# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-417.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-417.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "275d0b3af7a07d7ade498892b120431c32a62e6a426182f6455b06a3dccbaee8"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-417.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "628922f1bff9819e2bb3cc8c575f7d45d824e7aee065f9f66c48cf62f4aa736a"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-417.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "b3f4eb4e05e5bb4a5f053e24918cfe6458bc59c6f6e77235a66eeb1045cf0b5c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-417.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "d709dbacc3e718dc50a9442ea6cbac17df054d704515b18967a175ee3e32e70e"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-417.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "735c2adb31abafac131814e71de6ccf39cf84b785141c5d6d0d5b470245e26d6"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-417.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "ecd3e4ecfdc1a2cfbcdadace45bb2d711598d7866d32b061bcb20b30123f1d5c"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.6/sdk/dartsdk-macos-x64-release.zip"
    sha256 "999a66d6d67aef780a5cf455bdf551133587e79e7853a962412e4c79affa95da"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.6/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "3c6b54b6f44bca38bdc7858ea45734f297951eba5fb10c8fa7b86b4a3f43edb6"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.6/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0fdff25e6acba3d6094155a7e341634f8de3477e86c2fda4ad47232c1adf704f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.6/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "39f0642199b0ee376935ef81cdec24b658c33965819ed704cba3e6977efb3e0a"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.6/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "6913b7c0b3b78bc141d372cd473da21771e57372b1ab45c977ce1550c8ff0b9c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.6/sdk/dartsdk-linux-arm-release.zip"
      sha256 "7286b3a935c98ec9731c6e540614ef20e8ad8a1d6bef194c79e29d9837363de3"
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
