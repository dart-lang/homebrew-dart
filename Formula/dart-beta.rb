# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.14.0-211.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-211.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "05a0d727c3daed3292a5f7d6cfc60ca725fb98714a538ca22814a8a5b0279306"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-211.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "cc6087e7f3a806bb9b4e84f97a727278f41d39832573744cb7d6a2da128d873c"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-211.1.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "8424b776a20df02cf61c0fe60b385f6d888c2ee69c58489d050817a137e20a58"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-211.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "4af4d3da25c1a94b725aecfeeff0a5fc43306f93152db28b00f6f9d09b7459ea"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.14.0-211.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2f3ee3ed4b23fc3ef043399f3c6044b155e17edda653094c9b66a2ae220f17eb"
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
