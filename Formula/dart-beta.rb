# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.7.0-323.2.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-323.2.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f178b03c7194d49a965ab1838b4ab8547b99e52fd274c62ffd9893e6ba6023f7"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-323.2.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "faf3e07b1c34bff646d7fab4ffd0fe866e78c9e62ac9d24770a2fb8dd737ff06"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-323.2.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "77a239e591f2191ce0f1a7303ef536de4103ed4dd45201b08c77a67ee9cb09f5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-323.2.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "39559a0cf61bce129a2546d711365f719067c593af48dc274b1b4418968b70c0"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-323.2.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f6b865b4447eeb71b5f6b179e1c38bba0f758b808baae48eac80f9348801b67e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.7.0-323.2.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2ccdf0b9c0b7cd59c4993fdda32ec36e90c56deacc43bd58087ced4b23f198d5"
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
