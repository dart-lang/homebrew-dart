# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.15.0-148.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-148.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "9432a18f580b266ba7ad6d2997d0c579ec0cc7417e8ca69aecbcdce0e9abff58"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-148.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "d8cc04e664b0c7eb4b79dd525e5464258c86cdc393070b3b2767880da283f60d"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-148.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "14b4199874829a5d5b6003d7049a6415c826e82216346cb5db51a64d46347583"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-148.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "09db1d95c6ba3aa13cd677ccfe92b321db4ed86916dcb50881c3271b720d45aa"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-148.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "b6885fddd2976a66d23662e497cd691b290b0fc92ba1ba1c2d20a890bb19a7a6"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.14.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "3d440c968d4c1bb21c6d57eb1e3e364cea687899daef46b7cc99f07d328caaae"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.14.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "b670699f921bf307c3f2754b56349863ee9b2878661bcd446b50b90296e11311"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.14.1/sdk/dartsdk-linux-x64-release.zip"
    sha256 "759bed01e0aeb50e1a0b0a19474ba5c80c6087ce1d37b3214e475c81a44430e8"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.14.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c6e5581d478ac43ecf7d7028798b1bd10aef509f5e351184c755ec7eeeb1bea9"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.14.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f4296ab09348630716370bb93a538c54b9f7aa5a5d7f8990a464f93a00d89ddb"
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
