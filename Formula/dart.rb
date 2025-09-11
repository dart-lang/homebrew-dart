# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.10.0-186.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-186.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "a06746045b2a613e0f14e425b486901c9087cb3d50f093093064f20a5a75603f"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-186.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "253ffbed83c0fd4a126fcd5495da4061457f977dcdd628bbd0318fe0c101feec"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-186.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "786519de0a1367aaad435f0d6f18f09c89a1e39f10d378d248bc2ca1f5db34b7"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-186.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "00b24a16a909ce6399cdb77f1d08e7c4169c7b4d78e72fcfca28f72b3b935d46"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-186.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "d1b55a5b790a955dc9f62ea28cc7542f696231cb5bd146489d5ac9ef2561ea12"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "42763d286ff3163fb9a3fe30751d251131e1467ddaea5df8d2cff26ee356c71d"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "68c48c395e64cdde3ccf96908238e942824d5b39f3e2c96b5d2742f0b45ef2ef"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.3/sdk/dartsdk-linux-x64-release.zip"
    sha256 "d19311deb35104a41a40db7ae36c496b1503745a5caed5a415d322b4c273f1db"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "8847c4847bf77aed958c062bccf8d595795ed484876712680baf4c6c8317c356"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "19eb5aefdeb2322fb4cd6f6353f5acfa8a6e737307bcf83e066c648762996911"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"].select { |f| File.executable?(f) }
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
