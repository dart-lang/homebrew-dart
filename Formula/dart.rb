# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.9.0-268.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-268.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "12cc9041aef6e66d32abef4b97e921845f3f014b687e0530524af9044da87b58"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-268.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "4e980ea18254486fe4502dab83a035a5fe805d3c6a0563757f923bce247bea25"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-268.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "aba39c8e44ca836910ec22b9d7dad4565c8c41cfa31f1f2df75f2ce5c5a19c4e"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-268.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "f5444e43e8ca49773ffc9a56cd7862bc81a9a37d5e1d82e5a4ec6f23c9249520"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-268.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "38767c3527b6da16df73310e5edd21a82bcd7cb0fd6d8f45939fb5599d9bcd7f"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "39371df3d64f94f5b3d9c1119c3f549164c5628c6a13b9451b7b44859f1f9114"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "5080bc6f4a78ccce0e38e71e46476c08d61e081453646948f3f0c77177a928f8"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-linux-x64-release.zip"
    sha256 "0d58c010a361f3f1588b1c2f57942f7ccaf7b7abbe03404fef7a102eb638f09d"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "78a3240097bee3b79b009c69ead22e1aaedededcbe093eaa980084c5661096c8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "02adb724b0b684573f7630b3d79ef729f8cf9fff561f5170bcc195ee2477e1e6"
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
