# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.18.0-146.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-146.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "25115256535791058f37460b2a09e168e9d15ddd15fc3906082161e04bc2299d"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-146.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "ca7cf38c8a36f7bf19ded51f9514d5f26f8a30ed0712fb70428261882b689974"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-146.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "0ec170f47836f9f65c07071b08a845e0f3d95b5db5119d5b13f8da74f259ffe1"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-146.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "58d117f1c2fdb7dca24b50ff9a77b8964343af669a742eb13199473d5716e3c9"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-146.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "22cc836820a18f2bc4135d69660b7b14578a2113df3967bfb49801cbf85c43f1"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-146.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "9ff4e8bf75727e8def1f8822ca39947e358ca20f733d3fff79f532320f192839"
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
