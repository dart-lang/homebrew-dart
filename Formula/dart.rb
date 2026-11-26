# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.15.0-164.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-164.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "0a6638438f189a47646af425013af407a8ea3235e182e638c9ac54e1c563f533"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-164.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "93f46b644cd7f625f80883f01e9850bafff97f379164718d0bc048fcb9f4947c"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-164.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "24165bcdffa13b7b9c1a14267415693f187fa32b921a980196662a400ffc301a"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-164.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "d9099824f4349e823a6478c5ab9b67718a7f7e8b4c54696fc0187f70d2c79ddb"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-164.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "2a23fd0748c275dacb635c41d9b3f4e5592388bb5f5d867280510443690b64d3"
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
