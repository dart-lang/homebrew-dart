# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.15.0-139.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-139.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "93fdba4cfb4f76a512ce9f149ee511f6061ae787daf182bb0a11d888823113ad"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-139.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "fdd8b34443801afcfc0ff0db3ae3f2ac869780908b73c20ec473c3b00c590373"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-139.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "3891a81d54fab46af006c481b34ea536b5e3a4936f29e4e8168e117e876b8c85"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-139.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "f049a24f5b7e4ea9cc2195089db1195196c913f0ec1a65a3a0e74d72ebc4bc0b"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-139.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "fad401cb558be15fcdd8ade1cdaa123ff078c3c99a9a67d863eaa8d9fb44103b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-139.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "2b3bd431a817c450fe5e31a3e74cac38efe33a32a601a976a6df2afc00de3390"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "d0c24bcbda37950ae37e4e7e7cdf93f098cfea8ada39fd7ee6e06c7d97ced704"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c9e7ec9be908b2f8352730d9475853d008176fc9c00b3484a65033c739c36c61"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "bd352ab4df3de74f837dcc95f86917d925d71793c4b26c2650e0cf814c6e22bf"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "302cba4dea5f772caca6c61be78657a1122a427908d4db04c960b4f004ddb5ad"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e1e5514fc31457b5743781d72054398492d19a37163ace2ac3913b82017f4acc"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "09f57f277608e52086bd290775ea5991c6eefdbe54e6dc491550fd9ddb7c72f2"
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
