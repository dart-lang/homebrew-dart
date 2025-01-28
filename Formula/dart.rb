# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.8.0-38.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-38.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "00f9f74e0901a9357bd3f437e2294c48ac812b2bd4edef51bda63f0f36802b0b"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-38.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "9f5883dc5bd70699df4085c60d7b33a7cd390e1f47409600cbed4f8925fe71be"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-38.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "6e324c9dd62798aeaf0f95f44de1ac5b1305c9a7a4a31ed7f6e71e3cfd46ee1b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-38.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "c5ab02174fd6cfd6ede37265b4640313d823ff6f63e86b2ec5240c8c2ffacf97"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-38.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "05af249e94cef8241815f32de0ede3177575ae6eb023a2ef04cbb0bf59bd0de6"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.8.0-38.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "83c269e4032a6b06574c64fdbb47122184282e64eb917289bfd2a52c22c5016c"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b797e4e9ab31192264a9ff8d148f3d58f05f0f8cdf82f04c59fd67832c55daff"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "8fd91cb89fe883c448a26e6e34d861d51d9451976c56db2287c5f2df80191ff4"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "fbed37419784149c93f3ae444b9a9d1b5d5b73a521cbce731899d601d9b435b4"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "23dbdbd8020aeba52c694eeaebe4c29bc2be5476056b5750bffbb2d231371584"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "9192cc5efe2af1ff91aae692950550ae4eb649656e5e003c76b4ed55c328154e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2792acd3abfba7f3d61fef7d0973bbd8069f5f0ebaa3a4bc47222cbf8d4811bf"
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
