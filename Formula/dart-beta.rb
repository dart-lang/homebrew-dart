# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.5.0-180.3.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-180.3.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "0476ad7fb21d3a115c9180a3dbe174f888de27177533d474874669071220a1de"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-180.3.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "18d92df74ffddf4868850ff484f770f0819c33b3ecd84e1f425dac385f4f4e95"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-180.3.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "bc1269cc539193036c9b8b8394cc66bb2b1c493cf0932f8f3901eb17af7f9dbd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-180.3.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "d71db61d78d91197c353a08eb566a49f0e34be5e715974709071b8db015ee699"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-180.3.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "05fafa6b872a5512d5caf5aec88dc0e13bda595210d124f6886a4df11ecf834a"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.5.0-180.3.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "0ec722221ce891c0f37acc53e22031984fcec32655eadf16be1d68882f88cd1d"
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
