# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-356.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-356.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "6191d3f62f16b90269234d4ef92e3b5c78bdc7d92ac3cad58a56f4b0b461e653"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-356.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "3594d77b08f34d01e3607796d6cd5bb1eb4a7419b95505a1e60479e7ff987201"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-356.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "ae568da9ccd1ca35fc4bedb4463214fd475155d9cd937d23e3a5a3f7b2c7b69d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-356.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "fa19848bb0e52d93c3c9c76d319fac6be3367bbb3767c4b13ad96c62a8f85afa"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-356.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "43d32c7a57c3a30d4a7ef5d7741a3957857e81d8048d7ae5f9929bbcb905d0b1"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-356.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "64d888c2d050aeff805cb0bdc7a2e3a1b7ff318d1df004e9229ad5b7be8803dd"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "d5186e8d9a31260b3528b1e595be1744e76035bc136733860064c2483e0d3bd6"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.5/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "af19ba3c7ca6fb31a7334d960d4a002672dbf26b6377254aa28ffd67dfe4ea3b"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.5/sdk/dartsdk-linux-x64-release.zip"
      sha256 "1c56de9877367f2ba9bd78f1916c8991a464301814e052e413186ea3f5edcaa5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.5/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "187e3785e721cd38939600fa94a7fcd507b144ff59f6d11b80f85d159f47abe8"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e885c4a96fc578d3dd5db7bcb7d5d4f86a2cc3eebeacd12153787982e0f0ce10"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "5f6773acaa41fda33cb266b0ad1968bc6d6fd2f876b43cab62692ac5273b0861"
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
