# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.11.0-56.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-56.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "b8ce91ebe0468fb772eefc051c065c52a0530e7c6c8678f32f25e3dba6d8e3b0"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-56.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "404c06df75ffc6f72f5e0681290481d43e6cfceb32c2bc82453f0728752d7ed6"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-56.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "d74307a94e7bfbb191a95045b5f48db68090038d093c2eeb348d67f585e7c271"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-56.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "b3c127c80882a3cbbbc5130f3b4d3799df095e992d3682a1a663fe24020135d4"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-56.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "c58df4cf19619b04dcaf0497fa1a6672c149d8a34c57d86abee8cc010b39ea2f"
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
