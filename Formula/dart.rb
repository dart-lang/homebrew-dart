# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.10.0-271.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-271.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "b34ffeb9a478fb8a7b7683a7482063d72f43fdb4714b243fe77bf057c646a220"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-271.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "764756c972cd6202442d8d992bb454ff13c785e5ebe0e9c63b8649e1eb7d24da"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-271.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "bbc7f5a883a0723182df3bd24a5f913351fa8a2bec200189329551ee7aeaf680"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-271.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "a6c8e81c7d5a16e6763a64f1876ba8bd9cf8a20f055a96d760e4eff0b2c3c910"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-271.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "ca255d0fedfff979b4f08997a9d61496fcf04334b52ba3d7a477b88876b44136"
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
