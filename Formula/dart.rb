# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.4.0-131.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-131.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "f5688d19866437c5de497b7947f497fadb8e4117dc6ccc4cfac2660d612498a6"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-131.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "a4edaf6754f9fed15043ffeabaa5170016828ef7dc97580034e44ce29482372e"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-131.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "3e040e6fe43da6729a661b17b8e4348046d1e8604038f66fd5865439bd9f500b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-131.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "9720f4d17dbddf6f89522c844516702416e431754bb1d42202ac7017f5dd5ec5"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-131.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "5fe37f041ca4ca0962561b034f2cf644d64e5dcae0e48136acd5a3ee7ed2a78c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-131.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "59190de920fd1bc0ea026b6140b575a29bded2c3f3eba6bb81738cc8a5044f07"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.6/sdk/dartsdk-macos-x64-release.zip"
    sha256 "97661f20230686381f4fc5b05a63c6b5d5abc9570bf93ad4e5fc09309cd98517"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.6/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "2e04c91039f9cc05b2e93ce788aa1ce08bc4df5b50c84d6b4e21ba2b2538adb6"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.6/sdk/dartsdk-linux-x64-release.zip"
      sha256 "253390a14f6f5d764c82df4b2c2cf18a1c30a8e1fe0849448cc4fedabaaf1d48"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.6/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "91f106e29013e2fd0f0b58e18cde0f026997d5d9d55ac747a319b8d3ec6e8956"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.6/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "9818a37dd39e8e91a0159bdd2522213f9d36bbd99b715465b4606190e6ae41c3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.6/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ee647813284e4464a46ffcf9af36ef8d891494056238f7b52a0485fcdefedb5a"
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
