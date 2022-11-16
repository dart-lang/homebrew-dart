# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-374.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-374.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "b199e27cfe9a0683378a82f86ccddda995f96fb15982076627063f21558aa329"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-374.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "b3a24afd86c202fbe1c2e45b9646cd565052d228ece3874f7701cf77e177b598"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-374.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "fa459c42afe7d0c581f8cfab1c6cc48f4c64d3ce0fada102c5eb972d3d7484e5"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-374.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "fcd3e342917b7c64d9497e2b7a50f56cd20226629505d68548d781135b05e842"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-374.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "80b53fe7105cc4a6f92831d9f11b978829890aabbb2dca3acbe044bb3783e62e"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-374.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "cbbe625f07219519e9db5e3422a35eb7faae2db4199e1f77f0349d3111659836"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "350b9150b95d78405942e2d75aa7b4c7f2ed9fdd828bea39f1f6c069d3470fa5"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "2a6b49eb9285bd81d9b17b273db303b274f2de95e74171a2031f42c18abc9dc9"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "945c3e29ac7386e00c9eeeb2a5ccc836acb0ce9883fbc29df82fd41c90eb3bd6"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "a9bfb23d590cc22fdd349d2803bdad463a97f5d75853217e030cb2ea37fb3315"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b279454d8e2827800b18b736d745126c8d99ffffdcc752156145a6ed5a39cf62"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "746c3e134598341d1d71680725eb9289a402c6621cae55ae48758e0bad3f7849"
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
