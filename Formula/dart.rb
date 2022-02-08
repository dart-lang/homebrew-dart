# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.17.0-85.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-85.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "b166d148f9bfb77938bc2093bdcf70fc783218714ddfa9d0a11c40a6f7830433"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-85.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "ead3c03ff823023808d935be21db15bdc72d4bf3d9e2f09c69c8321cfb21b10b"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-85.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "ea79cc9738915f6637032c20772f5da5b3c8ed4e276fb16319c25f94622140c1"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-85.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a13bbc08c6f9816e8ebe70c21e576fd2a1b61382e511acc48ee6d43de22844da"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-85.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "b6ddac9f32bd48a69c79aab6322393e4350ce4a99d177412bce510fe590e6d98"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.17.0-85.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "9775c3860f2ba3ad36ce5a20102d4a5d29cdd9f746fc8e82ac47f38a76e0ee55"
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
