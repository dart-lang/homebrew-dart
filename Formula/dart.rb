# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.1.0-174.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-174.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "7dfc0dac5bd2301b1cde44dd4785de9a62b1590826022fa85fcdfaef52529585"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-174.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "688052e0b62f5b120729abe2fe5a9c834fb4803b6a8b39e64a0d7fb51ce69fcf"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-174.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "14bef942c86e78166ba557cfcd4bc42123499dee89189de90c89d31e92d4b904"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-174.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "9dc12b864560bef6e16031b7f0bd16408a5da4654107dcb4fd3da5aaf0667245"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-174.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "6a642e19a9e2d3be2ae08e36a815d934160c4157fa6d84a88a15f000e211921a"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.1.0-174.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "d955bf4bc90a3bbc2876f376a8bb90cc475095c20e4afd00f287c695bd0f7d27"
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
