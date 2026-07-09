# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.13.0-282.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-282.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "1700d4549df48677e16d96f130873a383099c6b1bb12dc661ea10bd7294c1cba"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-282.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "2aa4ede16afecc62578b41848dac9eb5e28488b8285cae3846ab9438ff5f0899"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-282.1.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "c51830deb8d9b3b64725601b5f2a8b2b3cb49a4cbabdede5274c6cd0550a9e66"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-282.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "2a8282d286df1834b0c9a274d2ae452d329de4da15fa576979aeb5c0168da1ba"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-282.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2a7a6c6bde4e8da064380870f1eba5d004784610f3b74dac76fda2793840ab98"
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
