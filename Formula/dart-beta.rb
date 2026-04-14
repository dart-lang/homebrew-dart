# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.12.0-327.2.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "4326af350db086f5a539471c6c6790b6a535ec727ef5abe35b08342eaffec7c8"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "89018c153d402f065ebf2bd91e514de2960bb4635effda7a0f3695886266ba32"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.2.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "8471f7632d779ccee562d1a1b44c0eb771b3ad9a7f6b06fd3f82b6206672025d"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e5cd9cc0b45a9ddf2293ad24043db168f3f67ca788387166fc10cb8335469769"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "357763ff37d605689823e6c2b46c4c96a22c922514c82d57ca598647d04534eb"
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
