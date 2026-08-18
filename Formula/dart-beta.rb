# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.14.0-95.2.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-95.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "e9880c85f47a17c16e179a94a6b17d43ca2fd46b2233e4fbcacb561b2476f663"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-95.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "837a909b0ba935902b8f7d37ed66596863b72e12cac1c3febc5b9124f8be07bf"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-95.2.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "8cd9bf0f283d5c4612a0622124a89183457fcb8eb8d7c2929fb85bafd3c03ac3"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-95.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "d9f535f8913762f3d716a6f2a69f485bc846ff79d0455497ce1844a795c9a443"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-95.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "3ca78a19eede87996c57af245979e9114a13a477cc0c71379e8bfa9a628b6e83"
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
