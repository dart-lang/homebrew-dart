# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-353.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-353.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "09b6afae37f7dc0eb970b5cbb88ea376a3a5b858a7c361c31fb54d6520b9f4ff"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-353.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "4b0dfd63118abe407ca82eef41668286eb607f3f822eede34cb728ddc7f6330c"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-353.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "3f226a1c88ddd6ad2aff1bb2687b45ee81caa905cb8d5eaa39bdd81593c4e860"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-353.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "eb273d0cfa506eb60ddf7c31ece5a1c0f155d7b029fa669d3eca4480eb2532a4"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-353.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "3c05b5cf65ee729ad45944f9403aa6aca5c817bf54961b9d07e347059f157d5a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-353.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "a2fccbf61899fe7623c7aa43e2f952a8e38bcf2fb1f5e058b3af79b2d220d3de"
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
