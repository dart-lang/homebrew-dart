# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.1.0-84.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-84.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "07cd544a6ced2d742d6b6a1108350fc7eda3218759f061efaf32757430d829c1"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-84.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "af94a364455179154e2035fac3617b59a39547f89eeb04a8c7ff1f801f121f64"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-84.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "ab4662beed14739ee1b329dd920f10eada1d19226b28f09c56fcb2d0741fb613"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-84.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "9111310969fb4204207ce0ddb3b0f920607cacdb1f17b8e2b2d3c057f6415af7"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-84.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e9641cab9d7b11ead212064da06112573fb09cf30cea3030d285b7f7f493e433"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-84.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "6c472eca326cc649b27c4d112a6f80fb5f749f5e7098daebc99a43a0b3cd60f5"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "6049cad15ab9362c98d87ef20ee6ba2d80b393bfffeceab6c1dfdcd24d325b29"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "67ddfcd369e8a0d7b6875396b4ce055d6b54994cea2cea6ccd190fc0c9c406d0"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "a256514a66cbbb8e151b968a7098a72c81fa9e4f1b2680f0f7d046cc64762665"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "dc7d1bc145f04007337e556ab56bf4bbd31195368de2eb5009033ead0d630d9b"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "4dd7b18b6494fdac16ca6104533bb271af15c035e8558a0e4a77029fadb4255c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "d053f4e6ca1be368e6b971bca05c3cb5e8cd6e977b384f6d52a7d580311db423"
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
