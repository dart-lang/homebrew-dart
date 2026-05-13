# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.13.0-107.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-107.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "895a64150c7de327b5fb8b2d43f03a43fcd5567113e234f1c8094ad6c7cabf61"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-107.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "fd6925c60c02a4d27acf99c529a51c63288db4b819ce7c6bccaa060d50446678"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-107.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "9c3c052ea027ec09478394448134b94bc0171620b2a59f03973d1ad39dac558b"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-107.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "fbdbec7582ba17d5abe9cafcef78c7632416ddc69e939c40eff86164517bbfa2"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.13.0-107.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "a713569aecd933972eac0b0640ef74becd6cad7fc0ce9a9f41d1c2646f769ef2"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.6/sdk/dartsdk-macos-x64-release.zip"
    sha256 "81c726df7c196a5b481a51cec04c6c102c51c8e14c796f85759beeecced8721c"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.6/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "d3d888758f313af0cba74dcca157d2841772c96e0d47c64dd52bd54dcf11af76"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.6/sdk/dartsdk-linux-x64-release.zip"
    sha256 "ea0ff2396ea5af402ba3598a9139a0f4b1b3471d9d7e834882d1559622760add"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.6/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "3c1299f468eba0fd77cf9b82d7e768382c1e980837b60ca774a2ceb4f9d7db4b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.11.6/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ba594177d23c372c02a80dbeacd418094f78f44bfb67a60636cc32eafb662185"
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
