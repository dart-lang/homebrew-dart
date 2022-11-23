# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.19.0-374.2.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-374.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "480f214e9c75324c14593e1f05d871f809128587853cbd5fecda8af5653589b6"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-374.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "485a3bec60adbcccfa691f88010db1d1bbb3d901237da86003a333d81f974b2d"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-374.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3de768ca2def7f953f8fe17c5d4e332cd18f3220ecdf28bb331b007edf58551e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-374.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "aa0704f55da4425ceb7fd55ecd332f09b327ea80dc7d48c24e79f99991dc4a68"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-374.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "34ddc9dac6022102c212465dde93dba8cad65a5fe2d8b54646c1a6114e58b48c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-374.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "733eb0961b90bac88bbbe189e636a8dfae725f9fd0318d422b6445ad92c45671"
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
