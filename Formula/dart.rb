# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.5.0-155.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-155.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "596e1ae565ef76d4a41a7ea8b958977af0c1635e9d6791cf237f1b78673b1fcd"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-155.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "1c9d5c98d0b4d402ec4eb61cc6eb5a272ab86ab7f8db3447ce84c7c99038ef90"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-155.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "cef91f9f3a62ec66ba1faccd93b5fb6dd318cbf2a60c607de102817b60a479d3"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-155.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "460c41d10f6cdcc0488924dbc1cc9d83a6b7ae25180dd576f2be6f4d01f7e785"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-155.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "4b3b104cb47015da2933cf88042c6736a0bb8283ab9001870c3b9695c3187640"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-155.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "348f5505256e94954394085fe262d15f85edfc39a6cf7e91c16e9fcdd583868b"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "fc7c7c151c4bd2ec30d8d468d12c839c2be13c7569355ea60e0914dd1f7c2ff4"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "e7b6b78febbe2f6ed8795af03a90f19331ce97115107199119a113800d441c86"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "631acea14a87a3c5d34f4fbd67ec8670cfe1345cbaa8fb8a3c45095880858620"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "5fa0132def556dd45f163221dc0a5715f959ce6f1332a4d4a6301c0f849fe5e1"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "227562fab85cd9e7e842d282af376af0b4a717010b568016e0dd3b8524e7ac10"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "5553cfc3940dcece763683d71b23055bda2fcffa9fa1eaee721c1b5af2c73f61"
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
