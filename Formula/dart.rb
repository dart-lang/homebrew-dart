# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.18.0-149.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-149.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "8dadfed6396aae5fafc3b917f2450e2971acb6041013fd6e9cca4a22f2bc0817"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-149.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "5bd9ba7ab780a9cab42166624c39bc32807eb043410f2588f33f225be049afd9"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-149.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "e6011fd465e20daf5ee8913dce1e6f019d2272523c556884f5b169e53fabc387"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-149.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "1d7db73146bfcd5a4ae34a8197bb54e68cf505395d175f40e9d2122796d54da4"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-149.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "5dadef203b4e71eabf7af32a9dd4250c8f6a3850c258a70767cd63c9dbb837ca"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-149.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "abaee9ab919785ebd904ce147af5eee779cdeb86da8ab10ae842d546a7c6b4b4"
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
