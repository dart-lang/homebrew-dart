# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-400.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-400.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "ef0e25c5e6e6f83ba3a16f1ea746a969264639e02d0da4b0686d353535b5dffd"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-400.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "ebe8ef89246a208b8c7745d252203d70ed5a914564fc7ded2b8b966fd1c05e9a"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-400.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "737283f036d113c0a5f13577ef6730a45717e89595933d7b8efb4d4aa84727a4"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-400.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "3fc9afce09e4d902b97548d9851c38f2bb9ed7ee061b4bb8bff0e4b6c4794006"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-400.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "eb583af49d41b7ffd2f81ef7bac4f7006cf18d332c944c281d83354d4bf5c116"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-400.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "c74491ad4c7c3932d1ea3e8da0d36b63ddfc27c24617dffcda8a563b98584f4d"
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
