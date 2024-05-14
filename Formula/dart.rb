# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.5.0-147.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-147.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "9e5d0fcd551c00de83bf82b2ee0ff0f6d595c2281c05fdd7223512647e9c5ec6"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-147.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "b4f74cac718641b14183a0b836d4d030301f7cdf88ca0803329d4c52050b0f51"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-147.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "ae77888df653407251d4f6283bce3251f4bf8745bad810a40d3920af0f9dd0b1"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-147.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "a843b9a4e1c4bc15658156d741034282c2f445aa06f0e27b7c7cc963cdd4811d"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-147.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "e8dd2ebfa053330e3f707441f09e47cc7a478e0fe7b3a4b0a1907f576d21eb83"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-147.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "16ee8e1488ad227718c822242395ba7dc3e82c3d4274857a69d475ba17a9b809"
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
