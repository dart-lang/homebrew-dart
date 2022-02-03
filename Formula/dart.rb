# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.17.0-69.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-69.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "dab8c79f40ee48bb88caf389d60ef1a167583ecd75cb6e93bbdd890cc9a80539"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-69.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "7d23277e5add7e15cacd6addeee87fcd4a21fc894c85543c32bd90e49ff9e07f"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-69.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "b33662233081d04b4f5cec82d92dd5ed4316fe87abff5d3708cd8a4c76665925"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-69.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "abeca6de7e524612e1e33176ce1f8948ef1099149778ce211937514be09c4436"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-69.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "97d13e4f0faca7768a593119d06292322594fc5610a336455e9d745d0de1a229"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-69.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "dbda9b6da0200388fd8a957785018cf276d3090b277cf000742a73c40a2e55a4"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "7e651c13727a21decc1afd9556c748b28ab198eab8f97e816003757643e2b67f"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "da64a3e34c996f72c5998bcefe156c6968927c8f8d543b450f98ec3af2f3194b"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "9fe86bde232de52d2211e47f5fdcc143ce936e309a8da1b447213e223d7f68d3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "9016bded6cf54b59126beef112f7bdd7838566218dc5df044e98d4257b3c926c"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "34e08cd8412a7a40265d202630a2220df82589d353d106dc3bc4a902fd44060b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.16.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "b2420751b9661f2d8c89931fdffdc915526889291b345911c310487d3274f56b"
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
