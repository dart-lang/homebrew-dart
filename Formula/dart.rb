# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.1.0-46.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-46.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "9d80c7f980302b46db9bc67714cfd8415b19e261864ab4ea39ade41e1db956b5"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-46.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "cc946eed3055cee61772ba5f337c94acbf391ff158c84da77b76b67cf67544ec"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-46.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "1820f3bdbe43a86d01748bfc05da339750c72ccd6d64d4fcdd40586e4f8f1028"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-46.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "8556773b9efcea5048fea1a00d66efcccbe6ba395aee18213634519e19d8b040"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-46.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "f91284e8047c819a22da28b9254b84167c5e9e0ff1697354fdb0e88719719215"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-46.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "eb99cc47b4fb5fef9177d0fb5a12d71f453cc27ab57a6f51782c49dc5c750c14"
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
