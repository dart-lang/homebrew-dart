# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.1.0-56.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-56.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "904a32aed70a78df254cf63b33486dcb7f94bc3c83e5aad14c15d90b2f37a813"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-56.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "68127a687ee59a3d08e2c02f0acc0279301f5fd3deb8e4efa0c7b8bff0b26113"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-56.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "d762982d10e28b7226137389419fe93a42899ee045ef98a16c58a60266cc182e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-56.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "bf1b163d86aebddb3e247530695621f74a40f309463e4baae2a47a129ce179f5"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-56.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "14bb3e35f0171fbf15e2c945cccdb3f8eb9a31f438851928b2bdb05d6382703b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-56.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "c1abbca81693215ac765e9179318bd7636d4f29454361595d8a9d9833e11ff91"
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
