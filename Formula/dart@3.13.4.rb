# typed: false
# frozen_string_literal: true

class DartAT3134 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "a8a75eb653a658d0e8238ec4a5b00a4a0023411d5d6ecc5f57e7cc19f7ae71e7"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "b36bdca9cd4bf987e1453e1e3ec45fb2c2a8c4df3246b510b66d3922bab04463"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.4/sdk/dartsdk-linux-x64-release.zip"
    sha256 "6487a10df5eab890d746d14a55f4c70bec3c1c0633f51804eb504cbc0fc395bb"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "1d545609bdf9da6fb5e68fbd96a599e2836e44ee64379991bd4493ee764d2fdb"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "72c5fa3ce50e6c1c2b42c6c6d3e1df28638497a12e0c7e64fce88d44994c2f1c"
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
