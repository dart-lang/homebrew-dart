# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.1.0-189.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-189.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "198925d160c66c7935664746ab982b55844597d4c5d43c4395707fc8024b51b7"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-189.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "a1d306cc8fa2f306cd36742443f199a78bb15627596445c987ea4a0ba661e0ab"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-189.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "b7cbc357a975122ee317e565b953304f6c134084e04ee42031bbb4fb05b8a1e9"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-189.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "2b12d8b69f9131070bf5c48a4455929681a8f0a3b02a3b74b11bf9257c6653f6"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-189.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "bc3312a0b01501116c20d97af6e768791c9d4e62f9802aa43fd9533e978ce451"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-189.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "3c2ecf7f91b17b5ae92459af99232cfba153c13fa4aead3f6d2fc7bd8fba6022"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "738c34bc63f77912b391d34cef121a92851053a759ba4a3187df4249a674e21e"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "10bd7379e619b509b726585523dbc276e03ed7aec1957cfb5e86bfccf0262bdc"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "fed758732d742df884d39770756eb9bd9fdb24665c24c96502a09e03a745fca5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "206b978e824608710e6af3e3301269397ffdec46235fe1d602063b9a30560bde"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "d04dee8e097cdfe02f7aa2d51620104ac680291f9d3b772a7c788694e0934fc1"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "36aebf7bf6d43574dc3f66872e1926e184dd2ef8641212240e57ab895403a967"
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
