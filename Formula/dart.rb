# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-339.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-339.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "8ddf6d248cf7fbd9518fee4f9843b15231fe13dfa97ad58e7cf70235234bf0f9"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-339.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "557b44b5d37d95b40374a8dccb9191c3bc831a88618b7fe90777ca60d3b5fa2e"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-339.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "bd5a692530406aec50a047ca877fbd0af95efa567b32aa1eec55ab6f287ce880"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-339.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "706a22e0dfcbadcd8835724a719583f334d7a520014436f8656455d03b8ebeec"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-339.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e640d9788642205e1f89f593fc5fec998a8ceea9c642219b9aab3087f4dbd017"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-339.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "02ca715bfebec092f37d7495f87490a5cfe8fc728fdf774f93ae312aee609647"
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
