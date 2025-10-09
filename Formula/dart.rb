# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.10.0-287.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-287.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "cdc227e2e41a5783cbf77b6b243119b72e9e1d491963352e314cf2c88d0d1c02"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-287.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "8eba0b267bdd8944ab6af27a026836dbb576459ed09fe0e3207864984901e5cd"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-287.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "aa7b29be4a4c6a1e174f0392497c2c420ee6ae05d934aae01a9e3fe5e9194e8e"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-287.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "8162299b073df9138b39aa03284e1408c9483144e5f9464f0d0d95240e03da8c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-287.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "263f2540f1215dbff4abd2057038e1c251f0440d2eb37dba25a7b57b58592247"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f27906d6150f9f4077af9c7106718c8e039aeba031dcb42056a331fb74e3dd2f"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "da0aa7f35e94b2ff25ebd42b7c9b21d430aee658e26da05f6509f84e15019480"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.4/sdk/dartsdk-linux-x64-release.zip"
    sha256 "61b4b9488e1b4255b94be17ad48ae2ddb23c6fbe67824cf8103d0b28fa8ab816"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "21790958b6c65cb57a1a3c3fb508f44ddcfb77b822a090039ee47e583fcde0e8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "8490f1d4a137e6b9edc628f7fe56bfa2d93ea22d07981b37bcb08c4248f03be8"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"].select { |f| File.executable?(f) }
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
