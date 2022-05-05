# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "2.17.0-266.10.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.10.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "12ccb57aa60d4d66e3af8f59d4d34bffe4fec83eb3cc1e5a1fe83e9dcfea93d3"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.10.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "ed228a4f5430de546d3e8acec32fac981404c904fe519eaec6e1080701a5e276"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.10.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "b57e68c74c1d72cdb78ac0203b4ded6e8e96c7311d1ca969322d4f7096a04b7c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.10.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "8e0adab543062236bf6dab609889d930432bb10795f7f633cbfcb88402773aa7"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.10.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c233288fc80e9b013fea21c9d6b2bba08ab25a59fb7146574a690200f1a4c474"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/2.17.0-266.10.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f18b68390f5dbf15cef7683e339578926c35fc3f20be9ef9ecf53abfd3c76c48"
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
