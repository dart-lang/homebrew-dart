# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.18.0-216.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-216.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "e33323889ec9842bd0b54189a32dd0004f19d65c7025472f014b1ddaafd28bf7"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-216.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "abb42af6500f9da1eb0e8aa992171ec6c062182c4b63566117efe907e54983ef"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-216.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "227c8eb3f9afca787cfecd9752fba819bc939673d8118c812c185638d1794caa"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-216.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "ba76bb51432ef05fb49e106670ee1975a5ac91a3d9e107cbad98e3092641fb10"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-216.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "c877ec731a7a1fc70e03b9d34be58ef78640ee3b5b45d5e0ecba71d366cf7e3b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.18.0-216.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "be93e169ca34b6cf8821413737a5d2761221d8eb1d3c1c318be7766e63fd3cbd"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "55e2ffe2ddbcef88e7a7fcb87348ff10934234f0ecbd9b463316018e8bb7d8a8"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "ca0c0df7085465a616b86919fa66440632aedfd7a26cda16f3412421f8e6ee96"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0052467a23ec8d46523be0f29263881444e0da3228860eb6b69de0859aca2459"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "26dd57fd191638196374bc77059a988b5510d7cb169d3032a2bde47ccc4f1957"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0482ba914c7e9befc67d1ff0057bfcae354d6cfeb0d4716f1ff44623089a2688"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.17.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "00e855429cd7345a56235a7b216967d23c22d0c1a0417249c4323b1cbfe9af62"
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
