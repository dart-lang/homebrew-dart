# typed: false
# frozen_string_literal: true

class DartAT3108 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.8/sdk/dartsdk-macos-x64-release.zip"
    sha256 "1302ebc990d529eabe2233f379dc1171747742dbb71dc818048a1c2c059b6527"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.8/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "bd0e32381d48f7bc3403209a411d82c5f7c8f1bd88e92f0c4f392bf46ebc0e0f"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.8/sdk/dartsdk-linux-x64-release.zip"
    sha256 "6712007d16203f8928b402800ded0e92357426b83b02417d1573db9cc88b75c4"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.8/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "584eea4c53f64feda68eba5dc4b2b024275c21003dfccd85a79e934faaac0921"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.8/sdk/dartsdk-linux-arm-release.zip"
      sha256 "bf800929f939aa2e5278194b10e6f8abf8a29b72d13bdb49cb2460cb316178f8"
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
