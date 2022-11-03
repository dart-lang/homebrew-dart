# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-361.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-361.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "5e731baaff9eca35745855b375c8b2b87dfeae937d02b15e04e2b9c94a6e0745"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-361.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "2ce9dacb80cb38b14d48da914f9302f1ac21a06c3fd5a592f805eded534657d0"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-361.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "1e04c6dee4280ed7041cba83338410067d6cdc09e7bf0b1f7876187394f775c7"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-361.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "1e83d48ad535652b15a97fccfcbeafcc56a875da599b431fa5b23613ccb5d484"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-361.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "dd4868972579debce75fef2bbd6f855ed503bedb599ff2a2215a47963ed52f6f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-361.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "d1d732039c29ef57b1a4cd5add141c889397532a7a1f3e8cd30682bdd973502f"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "350b9150b95d78405942e2d75aa7b4c7f2ed9fdd828bea39f1f6c069d3470fa5"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "2a6b49eb9285bd81d9b17b273db303b274f2de95e74171a2031f42c18abc9dc9"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "945c3e29ac7386e00c9eeeb2a5ccc836acb0ce9883fbc29df82fd41c90eb3bd6"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "a9bfb23d590cc22fdd349d2803bdad463a97f5d75853217e030cb2ea37fb3315"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b279454d8e2827800b18b736d745126c8d99ffffdcc752156145a6ed5a39cf62"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "746c3e134598341d1d71680725eb9289a402c6621cae55ae48758e0bad3f7849"
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
