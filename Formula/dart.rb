# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.10.0-231.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-231.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "a351dca5e894d8a2bf6cb0f7739cb55009bea0b73f438b8ad431b0eec09050c3"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-231.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "e2bc8f2906777986bc7179f9f1fdd288fd1f3da0fddc8656ef6a09bcdd85dfcb"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-231.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "712cd7e363e2600af57a964f8e28f8fc10b072eb36e3d3902ecd4cf7ae913d91"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-231.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "194403b57e0fb97e7a3e896a8da7291b350c30bfafacc333c2d5de70d6861171"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-231.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "f5dac916ce0710e3a0c985ac83f5ff99ad209e3d392389d98c1feb8671507e17"
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
