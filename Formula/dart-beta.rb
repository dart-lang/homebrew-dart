# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.10.0-162.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-162.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "6c68482d3a6ea09af84f1edf2a16e2883c835c3ed3ce6637ea8801b7659d32a6"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-162.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "03f7ca0395c166ab898737f449b6030fb259050e5e6e214625d2f3e0c958a001"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-162.1.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "aff507c0c17e4b749b72ecba0f42030f1541fc3dd52daf8c2bf29a9478537800"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-162.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "9e231c949e010a4576df1afa9a00e15d5e58a4094ebad071420183ee34a8ad46"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-162.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "3d4a719368dd8705e95c3ffc71201048ded208b64e4fa39be7d93da2b3297b65"
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
