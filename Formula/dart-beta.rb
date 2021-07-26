# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.14.0-301.2.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-301.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f917d113e79ee8020d0f4b202ee4d049348d02a6ed59ca674106b10580a84e87"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-301.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "a8d8a6b99e84367d728948ca4f7d72fd824a346986fa1b2ccc928c77017973ba"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-301.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "bd4e3d41ba0b534b031964a5eae5be32774bf3588777545c1cb0a6bbe9b56cda"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-301.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "88e1a25350c614850922e822884eb0d6c2f9ad250b0e8719b80fe36547ec4b7a"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-301.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e890aa792c98f740c25de2735453475649c239225d9286bb2694d094ffa66af3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.14.0-301.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "6540f59a9a985f93952226f7be463d16157a29445a5b120221c0947e6893766b"
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
