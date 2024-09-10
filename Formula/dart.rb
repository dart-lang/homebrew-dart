# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.6.0-228.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-228.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "86321ac1e5774941306d0acc7df8db3721d410c65e3df6a9151536281ca1b650"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-228.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "b668f7807fa5f15dffebd6163c44575a99e7d3c96322e12816dd96776b7fe30b"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-228.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "8a1e62cf930ab69e3114fc59fb71347caa8fb2ae0105c2ba5050e51aeebad71e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-228.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "40db7e19ba63525baced8317d6683e9ad1f767c24e3e3badc92e77151a17152b"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-228.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "85b2cbacb1b77a14f32b4109d62cd40905f9b529d3691d82426424a2d8bb65ed"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-228.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "166ef65cdc61244a25b5ace85424b6e2d5a9293c353f240380b7b47b946df043"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "65f00ed58e635574fe69708644c65f2a938034ffd424832cd0a73ec5d63c304c"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "5bbbfd94db56131a5ffbbe106f7d3b15c8bc3436fbf8aaaef32cf28131e1d20c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0b50f0523eb1cdaa3c18bcb88f78b4dddfad9e3abced0aef05b0fd765b980d98"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "c43199ade3bca564204f8df3cf63c5194b53003afc5f519660786ac17e932f5b"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0a382412154fc12ce6dd6d25903281e3c33922b0d3857bc541baea054f09a1f2"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "6be11d8bf7e9f4b9a04ba3169be9af7f407f73c0eee60c0081c5f3871762489c"
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
