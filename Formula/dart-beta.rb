# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.14.0-377.4.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-377.4.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "996a8e0cc4d57a5d95b51b8c0677917c12143d5d12ebaee2cc1cffedc81eb047"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-377.4.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "e1b4d0c3f2250d750d28015eb073e90dbcabdd22219d482f805216fee4ba69af"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-377.4.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "c597b1d834d95c19554cb3d1794036c0906776cb4231158a64a0ff40165661fd"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-377.4.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c72fba3ccd9c1d1d2526c764ccbb2b3069b6cff2c420e68c3289312ba8a45a58"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-377.4.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "05ea05859aad467748a575e280a401a10467bed7ed957d467792ae9cf872236d"
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
