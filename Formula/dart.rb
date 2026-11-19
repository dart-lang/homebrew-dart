# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.15.0-157.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-157.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "df50132376a5be0638f5bafbfde2094dbb2a1e49863a229c6eb9d8b9b6b3fcac"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-157.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "7319f3d4292124cc2341a004559a8e762c87ea196d2ff6fc93e95c3db996ed68"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-157.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "d699e9f52b04e36e1d39759d3c9d3569c681ae0664401c0f8e4602827cf98303"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-157.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "553b3c08d2072ab047a3b0351bad0da31e19809751102a339320a337b8acfc4f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-157.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "5db0828ca1963f23072883a7e842fd879bbe5f011582438801480cc192cc31f7"
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
