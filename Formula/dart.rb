# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.6.0-300.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-300.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "98ed92ce847bcccafda95d917c01535c42c03537e3eef54f4989af3a46f871e1"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-300.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "3a611058d0f26a4de266ab95aeafc31275ed209f1cc9364d302a023e534f6790"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-300.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "309f63d65d11f175eb7f2510d3f31560ac25642de45a0322d93be20ff762aa14"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-300.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "6fbbdd1bec891cba8b1cb76c592c9a33f03d2c5972183d21d08a686a601b413e"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-300.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "92d47c820d9b227a15c5016cdfe96f648e258127ea67943697ce9437312dcf0c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-300.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "fcf4e6c767f6f80a12a451b1b5a93c602014633717a19d4c10326c0cc4472b28"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "7d673ca3ece0ff563061d65a0e5b84ac8905d26c257fc8dc3d543c8dafa1d0fc"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c73ea25a5b01312bfad0e222dbd6f0677c46e2a4faa19b9c2b18f8506da03f8b"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "34f6eb82b226dbeaf61ea12a6d9cdd2d3374f7baadc38a6da55545ebc6ba3500"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "5ea88c21ccc5d4388a9d304a47ac4633c40b24d54501ceb1c7b166b14497387d"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "fe82992506112aaf63aebbe2716c133db30ba2c98d97926c0947a2d8d023e5e6"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "30b485142f9bde8a967114a9094d499bdbb1bd3a101adadd5268ce1ac4c617db"
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
