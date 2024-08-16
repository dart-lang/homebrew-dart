# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.6.0-149.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-149.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "17e49cbbf439bd5a72c9d9e9a57c7a13e3b029ee7408c3395452bde1d8753fa2"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-149.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "a05bcf4ce47454c3ace1ad06739b2b57cbeaaa16de7e238576f94ad50e67dd05"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-149.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "ab909aa83180c4c0d319396b950d8e9bc2d6b1246cb9be97621cad73c849f71e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-149.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "7a891eff3b9529054b873210365c7fff7ba7198905b9f00729510810931813a4"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-149.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "43e40898fc0e68e12ceb8857e779a4be1f135dca1200a7dd9da8458921a85e3f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-149.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "dea18d3ec1a529f6b4af432a30f0516358f5e8785bb3fba72259076c020818d0"
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
