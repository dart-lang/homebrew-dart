# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.5.0-219.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-219.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "ac5e6ce80d44af7efcba937c1841cfad9da8a3de97d01a06f78bd642efa8ab26"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-219.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "58b007f359a62874000d5cb51bdd3a179f5b0d2c1033a5369a83042766cb0c94"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-219.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "3dcd39a97c12a9931ed31889648fe28ad0cb6f00d12a491103b843b6447b3b24"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-219.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "d608cd08081f83892750f7bd143a2e3396135f7ff78ad1b0e4bcf0155660d865"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-219.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "a4d8c5150da5bdcb5921f2a08a49a9b725fed327a0bf3386c7adbbf2173b6a2f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-219.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "96732fec76324d0c3b89cf507844586f7d521dfd8a127d090ac89adfb3931f9c"
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
