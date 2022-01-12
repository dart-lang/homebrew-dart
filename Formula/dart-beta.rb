# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.16.0-134.1.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-134.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f2abd9e9d45033b892a33639dcc8c30bd1e9a550d6497b044fbd3e43eb08bce3"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-134.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "8e9429692768722efd611c74e8dbd2f1bcbd742c9a07ed58deb0e161fdf26221"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-134.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "d2b4ccf63b9160354d63cce1dfd1b47134433047efeb612e2a6373b8d5524bc9"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-134.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "c23f996530eaa3cda3cfecaa37018ef46a193ca70e8ad789fefe5faf47c7953d"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-134.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "74a9513408c1ab648e93148477f3f59ce609c37289dadd09e83b273369c49fe1"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.16.0-134.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "b3fbb9b5e3c95e2c56d8e0a1d51c841db2908c7afe084842c8e5010a2e45b6f2"
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
