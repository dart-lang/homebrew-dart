# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.10.0-203.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-203.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "75d7ba6db4e08fcadbc6b020f9c231ea8cac1b456f93e329c22d4e848747954d"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-203.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "563814b111f10c99aba8bb0b4af997dfc9ad3dadae59867bd584dcd77627b39d"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-203.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "56442df3161dc5c1c3790f20e453231d37801d7a9d6730c0cf21bf545c8c5f47"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-203.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "0c6f45bcb40100c009f5bb6887c154f77547d93bcd813774a81e3a1c115a7750"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-203.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "399643e823f46af309ac96eed9d9d831c3131b0d707d202c5f6ffaf79f48b51d"
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
