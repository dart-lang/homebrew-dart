# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.18.0-109.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-109.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "ffb6bbe029bbcd1f442c7037d9d0a1b35b05b00acb47adf4be0cf70346e51e20"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-109.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "66d38ffd6bace1682c50a9df36bed71c58a26dba7bb30c6d8dc0bd6bec01245b"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-109.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "2cd0c60359ae9d2a456543dca1e91f1249619fe15db6f2d8342d6947e6fe5dca"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-109.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "91b055e5bb1426f7f964b9f7f21608d1df9bdac513a3455e0b5c5205bd299dc2"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-109.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "5a6223071e484d99f58d87bb6dfaf27778390d9a0176dd455613687bebbd30cf"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-109.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "fce8378250b8b6c9bf13d27f72b8599668a64b6bf51cec8b25fbfe15c153aa46"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "05bf24962fe1c4a579b91f418b7c83de9509159eb5588cff58b401350d40061f"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "29dc5e1bbf83ee94283d9016e240aec0b85f315228b128fba36c0e683cfc4426"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "696862ad8b7ecdceed43b85d4eb8279bc0f8dbb5b61b9e9afc86c54ecd7b40a2"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "f17adb112d5d590a8ee224fdfe64b77474093d866783e2a4373855698f353207"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e796c032598392526ef2438c9cb5a4d146ffccadb0b9af1215eed322a39926a3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "c2b3b3b8f5a5e21702ee59389ded2de4812d3239fd81a5ba82fd7f0442b7f2b7"
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
