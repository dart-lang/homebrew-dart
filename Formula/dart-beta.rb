# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.1.0"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.3.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "4dde2e8cf36a2e95c85360c2665b368c75782292b70911fb3eaa46490a04db4b"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.3.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "f4e155778fbf1c59adb372ae3ebe9e5ed88f14c2e7eb9a593bf54d6e956fc135"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.3.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "b3aa85b15bd13d619ba924524d5c7f082dc256a062ad34fe12ec824c9f05c2b3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.3.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "1ac36395139288fe51f4ac33b2ce3a1f42dc5948e2dc570b4b551122db4390c2"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.3.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b7644435c8acf1e73da3f1ce16889b7222fbab37a75111aff225422a1cc61cab"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.2.0-210.3.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "08ec044e8b77a46d89073b5e312848b8f65b00f93a62aecd902613cef0ad1f9d"
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
