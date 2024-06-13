# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.5.0-245.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-245.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "9f355273aacfa3c2ee3de69bc01e4eeb286cf7f5dca021b42e2c9e40dab57b60"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-245.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "7b75a812023325297a1e2eb637ca58a86f80766db4f6c44fbb99ac0c718850ff"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-245.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "40e32178c87274a59c40490278c9686237426d5eb5d3f8ef6cd8781b79e33464"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-245.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "d1593b0bc4afebf00c54015bd0a126396df9d91b164cf6d14ff8d40e6d7fc868"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-245.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "1ce6af5ca5dd251b9dc319fa3eea0b73e5a75ef6e0e6e65f6fd91924e0fe9889"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-245.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "54634571bd041640c6d531a61785362e9088a6f10181dc942be0a54ff228328c"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "d3c7df4f1405a2c8602d9eac780c9eda9f6539f40a60df435d0a040c886aa7fe"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "541c24aab14e7015aea91c1501bb59abf286b98d09133a1c7bb2092bdb923e4a"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "6366ae94486d27a0d450c0d9bb35b181978f700c7a547e98ab50dbc8fb6ecca3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "06b2b3c961c56a82c417534af61df32bd607494ee8643a5f35eff058fb4c8be9"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c155e6d2f09a3d0fe04de4600040798ee253662017e46bb451787c62f19bd576"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ffc16f542700371fa2ed1e2b18d72e804f67375f6f6dcf0c8dc0f014f16d70bc"
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
