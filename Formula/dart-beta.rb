# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.17.0-69.1.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-69.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "51312ca1ab4f21ab93821f61a3d25b8db7a631bb0af1146ad65bb7b5c4fc0dd0"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-69.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "2f743132c0172d4da453be4b775853cda2338615d66d04ca8c120c357c9098ee"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-69.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0500849a8f0fc166fd6ae3debc873e1ba30de61cc5e2d946452fb9887744bf91"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-69.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "8b27437c40abfd3881d46f701dcbb0af80ddf5069535d979d7787744046efaa1"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-69.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "fda0600c63682296ac51c67704b7347ec0bad7acca22c566a36eee09a1405308"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-69.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ab9284f799c7b78c4f5a42766fb9088418af5fc121a012d95cb91cfb89fde4cd"
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
