# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.11.0-83.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-83.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "14fef1eec7d5bf5606301a0a597f3b89cb9ad7d14bc47e98d1a64bbb5dbce598"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-83.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "534bd6beb591db4a495620601221dcfcbdac9e0ab056f03a6c9095afbc846407"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-83.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "f4958c45628508efb21f9c91e032c89fb813a380eb73baa84315b5e73457201c"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-83.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "388556e3a3cb9824574e430c51c4fd2eb68d05fbfc46e435a6e473bf6606ca8f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-83.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "749cfdeb2bc970cb70c465128b27f64553d776dc688c4833084bc0d0e18a0971"
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
