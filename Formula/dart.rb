# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-398.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-398.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "7127c993c933aad8f810ccbbd7f83b37ae009d5adf7243e686b35352eba8d25e"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-398.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "409c3f173d9b7ac40e52c2bf8da92a3a85078c76545cda4005ae3a6eac22653e"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-398.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "5f9338d0d6a774d310ff5900792b1ef047b8e2b6d50bc58b4d6ba62b7efaeb4c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-398.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "dee378764d801f145615f587a5e4e5dacc50566d057dbc890ac987c891b2fb16"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-398.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "cb6aaa1472520cb28e819e2a4d346c921f70a60821c717504c9e2940bab5e248"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-398.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "871d8407baefd72d1215511b578f5e8efb21fa7a60a00acde323b2a2d6aef0d7"
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
