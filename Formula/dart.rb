# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.15.0-257.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-257.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "e10678b6777838464ddf0313b32aaf07aa70cfd9b35b3c333a5a317517410966"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-257.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "2f423fa8bf5695647e1ed37999d97d793fdeb0c915d96a26aef10fc0d1b510e9"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-257.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "ce17d4b26a75748ab8208fb54eb05c3a1fd8b3a12ced4bcf12a1e8a81d5362b6"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-257.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "c907263133575bbf49db3cfd2772632c4693b19766259ad93bdfdb48565b7fbf"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-257.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "c4d4da3f9c61a97171cfdc8aa69aa48d4df7f50d2914d67fa49294b4b5fef947"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-257.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "c9291477ffb6ec6449ccc14cd5ba48c5a26462ecbcc35eb090aa4f7cada26e33"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c900f6ccb62e2f7526f457d00be8fc296e7c2ce9c7653cf007b5a4db7fe9a9ae"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "3abaf0c2d57e05c27c873aaa47b7d88e59c39d5fc78ae9894dfb880fa18945ea"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "49b6a98008ef546cb9c221461529d6c02cf2474bff098e0dc7e4ff1ef0f8a289"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "f6b73006af2e3bd1394877f2e539ef88ae6a93968a56d4124e3b0b5d68b4de36"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0477fae6fcff58fec18d912537f13d647fa0e137fce23401eea73102dce62351"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "796b64022615ea75f05f20a3d5e7018e52a1d26c06acb1d2b0b2faa5df491a64"
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
