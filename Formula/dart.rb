# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.6.0-310.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-310.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "e5701126b4810bdf335813777643fb9bfb0085a25f6e8a517b99eec7acce644e"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-310.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "13b9784cd80c3c61f0bfe783436a2f04730dd542712409f8ff1503a88d880eee"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-310.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "507d1f6cdd8b99a739ec472e485ba97140831dbe286da1cb505afe29f38d3df9"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-310.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "95ccbd97886d4eae64a6f9a32f0b3c7d94c14dacd7b686ae34183333f40cfc33"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-310.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e834c2171745d6adde58dbf08a68672bd05109d26969640e03c9469d6456436c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-310.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "86f5ccff69783ea4beb9ce96ca6213184c1a2ebc81b826f68b7c4eb4c0ba0600"
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
