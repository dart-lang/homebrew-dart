# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.6.0-122.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-122.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "b3624aac2262d086c56641c5f0b51e22678ad31491b05bcafe1872bdf2e208ec"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-122.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "15e6a015835ad03f23d3c9aa302a6d61a878ead369a90e54892c1a265a1c7268"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-122.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "3a57496d1dc183a7bd4eadb480255774cb5c20206deb53f3a1d84df0f616be86"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-122.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "6458a38cd61a187a58ce75fca82ad97ac012044437f0f7c0dbd9a47a4115fd24"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-122.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "a4d8f34462473343175199c27a97393e3ba15974712abc42ede41bbb266153f0"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-122.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "ff7a26695f1762b358ae877114f93345737441b36cee14505340d70192a6d6d1"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "68e6746c44eb4bf359e5b57f140b555f3c022536c58d3951ccf5fe8dc4011c32"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "730978a02a6d72b8a2e05ff7a6ef3dc34aa214ed7a1e79e06913ea7bf7227d94"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "011a1dd6ff4e0bb4a168f7b4e13063514fbc255dc52d1ad660bf5a28773e9773"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "13804762f99d2d80659a9850f8dbbcbfa6478ed5f27c59c0d12c96208faa9db3"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "ee2cbcc36a190a883254ddc28ef772c15735022bfc5cfc11a56dbaebd5353903"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "dec85f8439ae55f30cc29ad80b6486acd20c97b25dcaa1b3d05caab36c980323"
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
