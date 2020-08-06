class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.9.0"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "4083f92e8680f2196ca6007e445d192c3db3e5408e3de1c52545aa64e6d74f87"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "e88ad49f39c3a9f9584980df88e2e62106141469e4f638f67f0c74554516b7cb"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "e498f94c35f55628d6497fe5b322c108126955d1bd6e6c9c146501818a5f7af6"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "8d1bfc2ee538d8058701afffe8f766ecea2a8d6ecb2e47bf92a866838cbff36c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.9.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "45b1d2f9808fedb38c1c75cd5784552d7b612c0e8177327a7d14fcddddef15a1"
    end
  end

  head do
    version "2.10.0-4.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-4.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "40ae2c44877c0a0b17c2c184bbde3e964809ceb3cf9ac29bb543313875373805"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-4.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "816aac451354f3dc0817b95af45e55e0cd1ecfa9fb65e425676417ea6e121755"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-4.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "476e1c0d538d31228696b85fe5e6be237a18125e12dc1aa5ba2332fb07be34d3"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-4.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "27a3073e49775769f78956d460b2b0a714235d82899a373e5fe5e7a1304f8579"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.10.0-4.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "fd074f2b9937d242abae078419d0fb498ae5c8ebdbf2f1a4d0ea76db788f36c7"
      end
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
