# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.8.0-171.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-171.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "84121ad0158614e25157773712d270712f4eb62cb41342ca449ff5a70d33388d"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-171.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "ac868d86e96136e8613daf3ca62235aabf0a6a449285e7be6e5beb52852170d6"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-171.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "6478773aa70f9868bf8e3965e635b820e8542ff4857f58c64eb68a4a860768f9"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-171.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "1d0597b469f6689635e9bd89cf7f1c3d0fb81a47a97421aa7400446fcf9d85fd"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-171.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "39784695c5686fecbe0391a84a41e8424f94602f72ceea0196da22065f274e70"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.8.0-171.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "3a7e92421770478ca74eb35df08ed25e0e0b0a22d6dcddd7dae6480bb1a67e1d"
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
