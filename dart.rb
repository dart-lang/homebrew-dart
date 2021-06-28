# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "Dart SDK"
  homepage "https://dart.dev"

  version "2.13.4"
  head do
    version "2.14.0-241.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-241.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "1e1222c241102c96e0164d185bc491bf0bfd62e34c4a9f29c59bd7b59cb9c9b0"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-241.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "4fa89c6e78d9c364548aad51142a2fe0a48f147294debfc8ee2c54022c4f713e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-241.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "ef93d0cb6ffea02560639d703500b386e9c0a2e03d8bb046e113aba76d47f1e4"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-241.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e088d379c11890a87dbc822d38a3066e1c4108ea720e0123fa300fc64556622a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.14.0-241.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "70e6103b0faba93eac6e6d93aba4c7137ac9dde8b9fbbe92b346cd7093f89bb8"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "934e3951d399aa654f45851dfdf6614acc34a20aafd8631075194c02d58e0e4b"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "633a9aa4812b725ff587e2bbf16cd5839224cfe05dcd536e1a74804e80fdb4cd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "3116ac10532ec954d0dd31b99cb562279109909ba818dbe081b1c2059a8f50b8"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "4c6c2dad0cf2f61e5512660937d99c0c5c9d1a51e8f0ae3cea1307092c9cafb1"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f7733f30e44345237a817bf9104fee1e20820a5796162770b964adcaf705711d"
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
