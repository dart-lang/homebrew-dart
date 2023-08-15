# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.2.0-66.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-66.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "27c67edbc34ada9be562e07ab25aa6f9682c8278a20665a89637a55970a63cbe"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-66.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "b66a24168bb97ebf17a1f911c897e1737c8186c68dd05068530f21f82013c273"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-66.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "7d56e46c81b06d35d52070f25bd7f5845659ac9a0e9fd679c8b1a31da0fc284e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-66.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a8f05a05b950a84bb554937e6fa9f4b258238cfb7d0ec737b3ec1695449ce02c"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-66.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "307d5368a0d4c6e2376a7cc04f48a7d6e4773792fe4a47e97cdb48c06cd3e71b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.2.0-66.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "4aa910ecd76f0b713322037bd94127f259daf1db810b6c65ddf71e4fdf1aa53f"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.7/sdk/dartsdk-macos-x64-release.zip"
    sha256 "cb8e8bd8dedef5308795cc3d4917a00dfbcc73742aafb0d95bbee909a3ef398e"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.7/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "bbb6625d89fbb910543f185cffed88aae1bdb8ab1e487496f3a5c3d18159f979"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.7/sdk/dartsdk-linux-x64-release.zip"
      sha256 "cccd5300faa5a9abce12a5f77586e26350028cea82bb4ff8eeb55641b58a2e1d"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.7/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "e2e94c38f93a1e8eff4fb27ffc5c13368142499b0e8283991839c4d63efb0658"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.7/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "2c8eeaf0d3da60c4e14beec45ce3b39aca754f71b9fa3fb0c635ee28d6f44708"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.7/sdk/dartsdk-linux-arm-release.zip"
      sha256 "3a15d42cb1677ac5e50a23045cafe3bf5db2855a5287a3e9019b849fe8477897"
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
