# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.13.0-282.3.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-282.3.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "5d9d4720a3e6cb1e1f5b5f4c8bc8f0c8b5c1f1becca08f104d77edc792bf72a4"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-282.3.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c1c52b8fc642cfb993d60d254d33893d1ab26343b53b13eb67dcc5d8e322f730"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-282.3.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "65b8452103f0b238923603c74ad4760d28a99d07455923837c018c3b96b4fd69"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-282.3.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "9aeb16aebd0e8395d25d5ebec5ccb2acc0792af0e6f8e22b73ad65652e447ef3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-282.3.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "de9af74b072ade0e5d61a1065df8b0c04dc58907805352f50ddd1715731270a2"
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
