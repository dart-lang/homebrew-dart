# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-146.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-146.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "188054c964a1d1ef6caba6133df0b7c805deafac560de16ca46826093f3cc187"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-146.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "c5ab3bea345d2bbf62268914984d6cf04ea08f1a7a0f73e8e5e1aa8be8f2827b"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-146.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "688f8b5238632f53f6cbddee7ded17c665dccb00fb639ccab32a43437f18a4c8"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-146.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "f2201cb96f617b0b9da5f7daaad0086b8aa3db9ad18baec5d575689b090a1737"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-146.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "86c628337919bf7802a8551ce338046a95035dd7f075363811576e2828a0d415"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-146.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "8dd39c4ae3ab4f98c3022b8392d37c121ec7cb9f60eb3a090b03958bf6263236"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "cf2bbaafc6a421dfc01e904a1fde702575eed4b0fd08a4a159829fa699d2471e"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c1f521eab5f2f23002d135502735e1e12ad5d8342cf52bd8f0f1ad360671f9c0"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "e391c4ed8f623b9748f897cb585d629057c1141f9eaf8e9b2be118932ba11632"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "22448959f028713d65f05da2800911f98e4f3580f93d9d23db50fc68993d2426"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "06dd7c6eb6c903f5df8b23f9a35f7b1c35ccb869be6b5019c7dd93868ae2bfbf"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2e83b4a03a9210713a2c65d2c50bd680984c414c3c89d78baba5a20f378fac7d"
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
