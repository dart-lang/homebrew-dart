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
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "4c4664d675f69440b6e5bcbae80868817dcf657360ed233a78638060721b67a3"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "1083b8fc5dbd9db3d3801de5ee05bd53eab6036acd1572d5ee60e93d29b75aee"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "ec7cf3dab7b7b19f42bc5bbdde9f04911260ca828604e877862046ae10afc27e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "fc4a0d4970b6b91a0a8ab76c52e09e54393aaa9b0b53113db21e86e2a2f7a787"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "1bb01530d5caa7d623f3ea30307aa129d84e8fca9d63b36240ed8c3bfcdc9653"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "bb3633bc6a32cf676b9824421bbb1639c05c821dc3fde9727f62ba9eaf349ffe"
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
