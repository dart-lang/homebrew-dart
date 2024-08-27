# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.6.0-178.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-178.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "522dab5540acb5ee51886c5424496dff74053ba30886d1e0fd26389c07c47fdb"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-178.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "c76073a2d392d9da800df2ed4d15201007ba8729abd5fbaf7f1743a624d667b6"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-178.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "cf723dd277dce968d916d0b59a78491d75d46512c34b8715953a8ed84260f134"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-178.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "f48265262f26cc47f37f3720caf0f923b47e9d06a597494f2724f77b0ea0a9fa"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-178.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "806b6b5210fe0f51c5a559411dcb65a2431e83779f2ab36d902c7141198eef46"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-178.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "444a74dd9174fd1cdd88e0a523de2d642f34c51854eff772ffe830ed8bbfca32"
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
