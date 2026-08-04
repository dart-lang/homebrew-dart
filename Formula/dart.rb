# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.14.0-81.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-81.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "6af4dc93b1d18a5fd8df6ddf06a6517389433257667648cdde1099210542c2bb"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-81.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "a3150812354046708cfef3fcd9db408ff9b1f0b4659ee99631593126f076decf"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-81.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "72ba5a395abefa106984e52cab05c1b1c7606acce8fdbbc737d3c478a7108ec4"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-81.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "ca4eac6655e9c16f1fc2a5670f4591d89c8bdd6302ea9e1f9b4a69e59cba38f1"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-81.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "709ed82aaa105d1ecdb89a4e00b2dd00edd7f441da3dd2850a7ec3edf5c1149b"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "38199f56fe22f2235e76799191d5b9516e360369c61b6ba4411398d5d5920bab"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "cd8753928e77b6b665bd70dce0e64b4ec6d2e2fde141d6409bb716c8ac1f1c0a"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.2/sdk/dartsdk-linux-x64-release.zip"
    sha256 "28e47b44cf075f36771046c068bb0d174201cf9c7608744aed1cc23204299c2d"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f82c83ece7d168047550dfd4a664e4071ac7c488bddb72dc43102c22d7e0b518"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.12.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "659fd41329db2c17e5f186c351fff50ac026b0ed1770a6ace712364d309b4a39"
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
