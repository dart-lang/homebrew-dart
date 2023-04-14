# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.0.0-417.1.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "4666d2171425c9d07c0b74c63ce88e0f4b306121264ea786a9266eea26159468"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "273b28262810880eb4d9523ee2b43a6a9ad76d6b0338c0c2f47e73a76547f8fd"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "7062c3ae887fc9454610fd72ff12c23c8cc930a76a00300c2280656db3b968dd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "ee74e5805815de70f3a58c6b489736e127251f78be959e6b7a4c2e0ba9147efb"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c94ef155690e3216ef4accd3a09b0d6231e834a8882bbba74d060c106bee6561"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-417.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "174a9daa37caea31385b5a43ad3aca8843edfd81b36a22ef17250c103fd48853"
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
