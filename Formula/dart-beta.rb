# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.9.0-196.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-196.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "e6a8416dcb0076bc8d85e440c71600e5a3102c897b52b340188e099cd2d519bf"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-196.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "23ecbb0feff600b969912994aff3f1f4ba932b2d6df43863a615f41f74724cc6"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-196.1.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "d97e026a18428748fc3b4fd7762a6e6b03c44954ba5245d7ebef448832ad3efc"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-196.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e60b9ffd7b5fe2bbc8ee35c492521ba6bc07c94bac64ae7199ca77df737d61a3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.9.0-196.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "51522ceae050f3d6aeedd6a3702992daa34d8aca6e316ef8c33e46e3a3656ea6"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]
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