# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "Dart SDK"
  homepage "https://dart.dev"

  version "2.13.3"
  head do
    version "2.14.0-241.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-241.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "1e1222c241102c96e0164d185bc491bf0bfd62e34c4a9f29c59bd7b59cb9c9b0"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-241.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "4fa89c6e78d9c364548aad51142a2fe0a48f147294debfc8ee2c54022c4f713e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-241.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "ef93d0cb6ffea02560639d703500b386e9c0a2e03d8bb046e113aba76d47f1e4"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-241.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e088d379c11890a87dbc822d38a3066e1c4108ea720e0123fa300fc64556622a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-241.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "70e6103b0faba93eac6e6d93aba4c7137ac9dde8b9fbbe92b346cd7093f89bb8"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f5ebc9da1554b2901ae8fe46f83db3215acd4579f396d521f506740bde7eb73c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "b33ef6cc021e88345acd06333ddbbb5771130f4d23fdb6eb79dce7c31b78071c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "5b7f86633c9dc43893a179f8f6c42a74148d348269b0b3e0b40bde05fbd41be3"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f48adedbf471981b140d37126be0e54af4a167baebdc9e5241656582a930a4d5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f5a7dd1598eebd5f0fd20704adf6acc3cd23de1f2b93b6b59a657dd524e14b17"
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
