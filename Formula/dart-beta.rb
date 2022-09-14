# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.19.0-146.1.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-146.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "3842f48fad93acc682418bbec7c39e3da2e6f440af1b4ad88ffe500a3a98e1b1"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-146.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "6c7705348aa170081130ae4f0a3ced904d957f2941612160c1d58b26d162f2fb"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-146.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "602d5936c3fad0776b999df2090c4c53354891f386fa71e0d7de9923e94c16e6"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-146.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "5a93ab8fb75dd3eb82e98b44e80204b5346edce25c5aa2247b1c6161afce1a49"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-146.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "a1538410aed74e4f1c42962044ec7341b5ea6a74f815b049352f72c1f75e988b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.19.0-146.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "163ded97557dac79207bf8661854b82cb10d6104b3b8e39eaa866b575fca1fcf"
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
