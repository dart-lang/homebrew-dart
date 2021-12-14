# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.16.0-103.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-103.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "ca95ab938166fcd03d348b28a2a8dd76ffaa2786ca3618452561681e61eefe4c"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-103.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "8cfd055ce9b6dc8cd37f4e810b11319bd31af6847ce94c68373125211e25f7c7"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-103.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "680b51758c3d339ebd6ae9012b010b905b6f2aab18fd47fe716ae44718d41c62"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-103.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "20170b337f4530d360d739969a4f20a913575eb3cbfc536cf65c38d243943813"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-103.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "5c33e5335143460b2b8323117d42991922128e0ff360f92bed406745d93f0c51"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-103.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "b74471a0c91c854e17e9d5413758e56f604648c689e64ff7d0fbef02803115da"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "dd01b724f56c1dac2ee10ef47eb5d5ff7b2b872a2847b79ed671b180c556d17f"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "a781b7a2db86aa4699d39f39f6cb8695705a0b7f0af8113514c2e89fbbfd77b1"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "53557538f98578d642741c45cbbcaa01b004d1cc61f5fd94a8a426ade26ef580"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "d287215a54eb218325c302ceda2d462090aaa9774e4d5d30aab6d9684d10e3c8"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "bfa01d1842fccf9e59bfed8edbb3e43921d37b04d4cf1af6a6895e3bc6243000"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.15.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "22e112cfd0e99bf54ce000a55d63017e322bac9e810b61195d701c785de897f5"
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
