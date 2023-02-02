# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.0.0-187.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-187.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "ed3a9e10ba8b77cad2e81aac3033cb6688c986249b96a7068de9672b308187ee"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-187.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "15985db5206b656ea66ff3ded98d82573407a865269020937eadf2482160d18f"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-187.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "1b2995745816b817a2b3003faab9e312b06bde15349da3e9317017e56d16f5c5"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-187.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "5ad3639c30b177491abaaae9bb71e02278caf859f395cb63960e7800a4bbb48e"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-187.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "c496368a0aea5d485c80a94445cf92325237567f048a3fa6d1d29f11b2cd7dc8"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.0.0-187.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "61d4b57b560d61793e931d80d32c532dec9b56da56459d70c33ff51e9451ae17"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "ec29555e3ae0f739c9e86296dd0ccf88e8e43c7eb50d01e247379fcae8d78632"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "dec16f17d942e7c70cc385c672a81dd56118d49c32008f97bf9fc590bcedcbac"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "1390ab623dab8e6c23036e865cc8b6245476797f69c4c855e41bf9ff45928263"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "108d194601ec139dd2de8e079a5906adafe43f0cbceb347dfcd7256c7774796b"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "ba6ccdf8d73ada5be6533cf58a97044ef1180e2d0cd4c7e17da21b62bca65042"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.19.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "80b8abc7b3425561712bad6f6d7123217a26fa7697f8aac6dbf0e1e89ee6ea53"
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
