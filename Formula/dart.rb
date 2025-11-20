# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.11.0-150.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-150.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "a25b9ba39204e1043be58aeb3d6df28c78c8dac631561b659d65277614d35946"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-150.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "71049df0c3892d2060fcd73e22db94562ee563a2a57676014226fa04fe9b7d1d"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-150.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0d9815e3ba7dccb79e5458645a97bb63b27cdb9f77db1ca24e236024a48f4be1"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-150.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "dee54d9f22b5e8d7dceac0fca845d36162549d9cadfe47f4d966b481a4fe60b0"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-150.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "4a774d3c0151ee716f1a69cc4e8c7688192f47d62e45c381b0592d8e028feb57"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "462436904165ba6d3c72d265c019a5de63da2294edfd903d06073b3992b544c2"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "37d233029f48b75b368a35f0fa1eb728fc5780a03a4b28a2ec3bcc343884a6c8"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.1/sdk/dartsdk-linux-x64-release.zip"
    sha256 "a352fd18e0c07aab694bba9cf57e431eddce390550a90449b1ff880fee7736f4"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "60d33687806781175723f4cb7def7adf83ee0f981ca997d2eece40f975526b4c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "4b2e148019dfa1c1703ccc86aea45fe711ed09f190d853a26c172b5b962bf5bd"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"].select { |f| File.executable?(f) }
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
