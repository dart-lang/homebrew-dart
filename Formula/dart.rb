# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.14.0-93.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-93.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "8abdbc08d64f23e03c02a297d88a602bdce269d071ce6945606ddd2c8f1a969d"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-93.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "fb439bfcf907eb4eb7c80f455b209194bb24e6342306f48ce9a39b5f9aff3efb"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-93.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "4aa8e67313fe1c92d974164d0de2c98fd0dd432d21778b2922a6e716310b21ef"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-93.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "d27f87cc4afb11012d451da09c7384171d17bfa7055a2d31a557d03220bc9df2"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-93.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "f331a0c5262b448b1e4b095a8def3d42ceebafcbbf1e705f92fa5d61f535ada1"
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
