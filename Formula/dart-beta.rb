# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.12.0-327.5.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.5.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "0a8c31cd28b0f6698ef81496e76bdf927df2640ed1ae6b7015deb0eacb242174"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.5.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "660270802d0a9c63f6d00f8e5c8bd941a83eb25034d633dab181c78589158532"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.5.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "ccf7731b12d893775e11baed34447193ea314383314155a26167f319cece58b5"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.5.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e09bb89a033fa2351964debcfeb6638b40aa3c9d8d1b05ee72fe1ab850c99397"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.5.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "c25833e91bcdcd7d0726257e97272ad15f2c4162f0b6a9a1c4fb350a2b5df6c3"
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
