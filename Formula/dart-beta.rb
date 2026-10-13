# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.14.0-315.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-315.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "2c81358b1f8b5c21cc2ec40871064cb27811600e5ae8b52a96ee32cf4efd2f9a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-315.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "9821e5cf7ff4942d50450c7810acc47c397bf42d461d8ca6cc23743465a13d48"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-315.1.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "8ceaf3e7e022901be224e0c48404c8456a6943f2f9d20dbe6bbe2e3f09f4b63b"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-315.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "74a6b048af5d12068ef5c7173008fee1f5132cd775a5021d5302499cb1f985cd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-315.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "5cbad2c385e29aa29fd0432c4a0ce595f434aff8653d4e08fd6ddc233c0d8928"
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
