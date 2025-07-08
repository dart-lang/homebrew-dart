# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.9.0-314.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-314.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "6d3b369a630f19ca82c9d491ab0fff0b83dd5487ff27bdee0e7791f500817838"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-314.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "e983128956b4609abaf1e4171eaff92977d64cbf25e20fc2dd64cced7f440ba6"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-314.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "51ec3374b05669274bf60983b9b5815640c08cf16df63005787563ad9f0bc581"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-314.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "a8348bc345918738960777dafcc07d2b61b70ff4f542250f487ce09bf48453f2"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.9.0-314.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "fb6446f59217ae5eb3ddc5130f2d9dd2adba6bbddd1f3ac8c8103d3679a0cc30"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "39371df3d64f94f5b3d9c1119c3f549164c5628c6a13b9451b7b44859f1f9114"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "5080bc6f4a78ccce0e38e71e46476c08d61e081453646948f3f0c77177a928f8"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-linux-x64-release.zip"
    sha256 "0d58c010a361f3f1588b1c2f57942f7ccaf7b7abbe03404fef7a102eb638f09d"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "78a3240097bee3b79b009c69ead22e1aaedededcbe093eaa980084c5661096c8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "02adb724b0b684573f7630b3d79ef729f8cf9fff561f5170bcc195ee2477e1e6"
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
