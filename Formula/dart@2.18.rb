# typed: false
# frozen_string_literal: true

class DartAT218 < Formula
  desc "Dart SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.7/sdk/dartsdk-macos-x64-release.zip"
    sha256 "71675de774e19ccc872234ffcbd96401af49b88330001aeb47cff648eee790ca"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.7/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "2742114776a5b476f64cb96596eaeb2d346f65686b7f358b06de83f0e3eb2a48"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.7/sdk/dartsdk-linux-x64-release.zip"
      sha256 "337de0ad3ee66dca7ffa81fc3cd9ecd53d4593384da9d1dfcf4b68f69559fa2b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.7/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "3a02c848c1ea1ae2f7b0cae28ed5ec6a0160a795b7440e2e217aafa3eabeb0d3"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.7/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "684092802f280ca7a64b111da647bbd380d2ce5adf8a23bcd70cc902a3c4a495"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.7/sdk/dartsdk-linux-arm-release.zip"
      sha256 "daa5139774ba50f100115c79dc193c0bb0a48737c79eb915ee8f25c4ec74ace1"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{dart?*}"]
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
